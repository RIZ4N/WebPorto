import { createClient } from "@supabase/supabase-js";
import { cacheLife, cacheTag } from "next/cache";
import { fallbackGallery, fallbackReports } from "./content";

export type ReportSummary = {
  id: string;
  slug: string;
  title: string;
  /** Short tag beside the title, e.g. "Practicum 07". */
  label: string;
  summary: string;
  course: string;
  courseOrder: number;
  /** Order inside a course: higher comes first. */
  number: number;
  coverUrl: string | null;
  /** Its own page here, or the old site while its chapters aren't written yet. */
  href: string;
  external: boolean;
};

export type GalleryPhoto = { id: string; imageUrl: string; caption: string };

export type ReportSection = { id: string; title: string; content: string };

export type ReportDetail = ReportSummary & {
  legacyUrl: string | null;
  sections: ReportSection[];
};

type ReportRow = {
  id: string;
  slug: string;
  title: string;
  label: string;
  summary: string;
  number: number;
  cover_url: string | null;
  legacy_url: string | null;
  course: { name: string; sort_order: number } | null;
};

// Reads only what visitors may see; the database rules enforce that.
function publicClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  if (!url || !key) throw new Error("Supabase is not configured");
  return createClient(url, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

function toSummary(row: ReportRow, sectionCount: number): ReportSummary {
  const useLegacy = sectionCount === 0 && Boolean(row.legacy_url);
  return {
    id: row.id,
    slug: row.slug,
    title: row.title,
    label: row.label,
    summary: row.summary,
    course: row.course?.name ?? "Other",
    courseOrder: row.course?.sort_order ?? 99,
    number: row.number,
    coverUrl: row.cover_url,
    href: useLegacy ? row.legacy_url! : `/reports/${row.slug}`,
    external: useLegacy,
  };
}

const reportColumns =
  "id, slug, title, label, summary, number, cover_url, legacy_url, course:courses(name, sort_order)";

// Cached reads never throw: an error inside a cached function would fail the
// whole page, so a failed read returns "unavailable" and the caller decides.
// The short lifetime lets a failed read heal itself within a minute; saving in
// the admin panel refreshes it immediately through the "reports" tag.
type Loaded<T> = { ok: true; value: T } | { ok: false };

async function loadReports(): Promise<Loaded<ReportSummary[]>> {
  "use cache";
  cacheTag("reports");
  cacheLife("minutes");

  try {
    const { data, error } = await publicClient()
      .from("reports")
      .select(`${reportColumns}, sections:report_sections(count)`)
      .eq("status", "published")
      .order("published_at", { ascending: false })
      .order("number", { ascending: false });
    if (error) return { ok: false };

    const rows = data as unknown as (ReportRow & {
      sections: { count: number }[];
    })[];
    return {
      ok: true,
      value: rows.map((row) => toSummary(row, row.sections[0]?.count ?? 0)),
    };
  } catch {
    return { ok: false };
  }
}

async function loadReport(slug: string): Promise<Loaded<ReportDetail | null>> {
  "use cache";
  cacheTag("reports");
  cacheLife("minutes");

  try {
    const { data, error } = await publicClient()
      .from("reports")
      .select(
        `${reportColumns}, sections:report_sections(id, title, content, position)`,
      )
      .eq("status", "published")
      .eq("slug", slug)
      .maybeSingle();
    if (error) return { ok: false };
    if (!data) return { ok: true, value: null };

    const row = data as unknown as ReportRow & {
      sections: (ReportSection & { position: number })[];
    };
    const sections = [...row.sections]
      .sort((a, b) => a.position - b.position)
      .map(({ id, title, content }) => ({ id, title, content }));

    return {
      ok: true,
      value: {
        ...toSummary(row, sections.length),
        legacyUrl: row.legacy_url,
        sections,
      },
    };
  } catch {
    return { ok: false };
  }
}

async function loadGallery(): Promise<Loaded<GalleryPhoto[]>> {
  "use cache";
  cacheTag("gallery");
  cacheLife("minutes");

  try {
    const { data, error } = await publicClient()
      .from("gallery_photos")
      .select("id, image_url, caption")
      .order("position")
      .order("created_at");
    if (error) return { ok: false };
    return {
      ok: true,
      value: data.map((row) => ({
        id: row.id as string,
        imageUrl: row.image_url as string,
        caption: row.caption as string,
      })),
    };
  } catch {
    return { ok: false };
  }
}

/** Gallery photos in display order. Falls back to the built-in three if the database can't be reached. */
export async function getGallery(): Promise<GalleryPhoto[]> {
  const result = await loadGallery();
  return result.ok ? result.value : fallbackGallery;
}

/** Published reports, newest first. Falls back to the built-in list if the database can't be reached. */
export async function getReports(): Promise<ReportSummary[]> {
  const result = await loadReports();
  return result.ok ? result.value : fallbackReports;
}

export async function getReport(slug: string): Promise<ReportDetail | null> {
  const result = await loadReport(slug);
  return result.ok ? result.value : null;
}

/** Groups reports by course, courses in their set order, reports by number. */
export function groupByCourse(reports: ReportSummary[]) {
  const groups = new Map<string, { order: number; items: ReportSummary[] }>();
  for (const report of reports) {
    const group = groups.get(report.course) ?? {
      order: report.courseOrder,
      items: [],
    };
    group.items.push(report);
    groups.set(report.course, group);
  }
  return [...groups.entries()]
    .sort((a, b) => a[1].order - b[1].order)
    .map(([course, group]) => ({
      course,
      items: group.items.sort((a, b) => b.number - a.number),
    }));
}
