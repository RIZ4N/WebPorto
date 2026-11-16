"use client";

import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { useEffect, useRef, useState } from "react";
import { refreshContent } from "@/app/actions";
import { createClient } from "@/lib/supabase";
import { slugify } from "@/lib/slug";
import { RichEditor } from "./rich-editor";
import {
  errorMessage,
  inputClass,
  labelClass,
  primaryButton,
  quietButton,
} from "./ui";

type Course = { id: string; name: string };
type Status = "draft" | "published";
type Chapter = { id: string; title: string; content: string };

type Form = {
  title: string;
  slug: string;
  courseId: string;
  label: string;
  number: string;
  summary: string;
  coverUrl: string;
  legacyUrl: string;
  status: Status;
  publishedAt: string | null;
};

const emptyForm: Form = {
  title: "",
  slug: "",
  courseId: "",
  label: "",
  number: "",
  summary: "",
  coverUrl: "",
  legacyUrl: "",
  status: "draft",
  publishedAt: null,
};

async function uploadPicture(file: File) {
  const supabase = createClient();
  const extension = file.name.split(".").pop()?.toLowerCase() || "png";
  const path = `reports/${crypto.randomUUID()}.${extension}`;
  const { error } = await supabase.storage
    .from("media")
    .upload(path, file, { contentType: file.type, cacheControl: "31536000" });
  if (error) throw error;
  return supabase.storage.from("media").getPublicUrl(path).data.publicUrl;
}

export function ReportEditor() {
  const router = useRouter();
  const reportId = useSearchParams().get("id");

  const [loaded, setLoaded] = useState(false);
  const [courses, setCourses] = useState<Course[]>([]);
  const [form, setForm] = useState<Form>(emptyForm);
  const [chapters, setChapters] = useState<Chapter[]>([]);
  // The address follows the title until it is edited by hand or already saved.
  const [slugLocked, setSlugLocked] = useState(false);
  const [newCourse, setNewCourse] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState<{ tone: "ok" | "error"; text: string } | null>(
    null,
  );
  const coverInput = useRef<HTMLInputElement>(null);

  useEffect(() => {
    let cancelled = false;
    async function load() {
      const supabase = createClient();
      const { data: courseRows } = await supabase
        .from("courses")
        .select("id, name")
        .order("sort_order");
      if (cancelled) return;
      setCourses(courseRows ?? []);

      if (!reportId) {
        setForm({ ...emptyForm, courseId: courseRows?.[0]?.id ?? "" });
        setChapters([]);
        setSlugLocked(false);
        setLoaded(true);
        return;
      }

      const { data: report, error } = await supabase
        .from("reports")
        .select(
          "title, slug, course_id, label, number, summary, cover_url, legacy_url, status, published_at, sections:report_sections(id, title, content, position)",
        )
        .eq("id", reportId)
        .maybeSingle();
      if (cancelled) return;
      if (error || !report) {
        setMessage({
          tone: "error",
          text: error ? errorMessage(error) : "That report no longer exists.",
        });
        setLoaded(true);
        return;
      }
      setForm({
        title: report.title,
        slug: report.slug,
        courseId: report.course_id,
        label: report.label,
        number: report.number ? String(report.number) : "",
        summary: report.summary,
        coverUrl: report.cover_url ?? "",
        legacyUrl: report.legacy_url ?? "",
        status: report.status,
        publishedAt: report.published_at,
      });
      setChapters(
        [...report.sections]
          .sort((a, b) => a.position - b.position)
          .map(({ id, title, content }) => ({ id, title, content })),
      );
      setSlugLocked(true);
      setLoaded(true);
    }
    load();
    return () => {
      cancelled = true;
    };
  }, [reportId]);

  function update<K extends keyof Form>(key: K, value: Form[K]) {
    setForm((current) => ({ ...current, [key]: value }));
  }

  function changeTitle(title: string) {
    setForm((current) => ({
      ...current,
      title,
      slug: slugLocked ? current.slug : slugify(title),
    }));
  }

  function changeChapter(id: string, patch: Partial<Chapter>) {
    setChapters((current) =>
      current.map((chapter) => (chapter.id === id ? { ...chapter, ...patch } : chapter)),
    );
  }

  function moveChapter(index: number, offset: -1 | 1) {
    setChapters((current) => {
      const target = index + offset;
      if (target < 0 || target >= current.length) return current;
      const next = [...current];
      [next[index], next[target]] = [next[target], next[index]];
      return next;
    });
  }

  async function addCourse() {
    const name = newCourse?.trim();
    if (!name) return;
    const { data, error } = await createClient()
      .from("courses")
      .insert({ name, slug: slugify(name), sort_order: courses.length + 1 })
      .select("id, name")
      .single();
    if (error) {
      setMessage({ tone: "error", text: errorMessage(error) });
      return;
    }
    setCourses((current) => [...current, data]);
    update("courseId", data.id);
    setNewCourse(null);
  }

  async function changeCover(file: File | undefined) {
    if (!file) return;
    try {
      update("coverUrl", await uploadPicture(file));
    } catch (error) {
      setMessage({ tone: "error", text: errorMessage(error) });
    } finally {
      if (coverInput.current) coverInput.current.value = "";
    }
  }

  async function save(status: Status) {
    const title = form.title.trim();
    if (!title) {
      setMessage({ tone: "error", text: "Give the report a title first." });
      return;
    }
    if (!form.courseId) {
      setMessage({ tone: "error", text: "Choose a course first." });
      return;
    }

    setSaving(true);
    setMessage(null);
    const supabase = createClient();
    const now = new Date().toISOString();
    const publishedAt =
      status === "published" ? (form.publishedAt ?? now) : form.publishedAt;
    const slug = slugify(form.slug || title);
    const payload = {
      course_id: form.courseId,
      title,
      slug,
      label: form.label.trim(),
      number: Number.parseInt(form.number, 10) || 0,
      summary: form.summary.trim(),
      cover_url: form.coverUrl || null,
      legacy_url: form.legacyUrl.trim() || null,
      status,
      published_at: publishedAt,
      updated_at: now,
    };

    try {
      let id = reportId;
      if (id) {
        const { error } = await supabase.from("reports").update(payload).eq("id", id);
        if (error) throw error;
      } else {
        const { data, error } = await supabase
          .from("reports")
          .insert(payload)
          .select("id")
          .single();
        if (error) throw error;
        id = data.id as string;
      }

      const rows = chapters.map((chapter, index) => ({
        id: chapter.id,
        report_id: id,
        title: chapter.title.trim() || `Chapter ${index + 1}`,
        content: chapter.content,
        position: index,
      }));
      if (rows.length > 0) {
        const { error } = await supabase.from("report_sections").upsert(rows);
        if (error) throw error;
      }
      // Drop chapters that were removed in the editor.
      let removal = supabase.from("report_sections").delete().eq("report_id", id);
      if (rows.length > 0) {
        removal = removal.not("id", "in", `(${rows.map((row) => row.id).join(",")})`);
      }
      const { error: removalError } = await removal;
      if (removalError) throw removalError;

      await refreshContent();
      setForm((current) => ({ ...current, slug, status, publishedAt }));
      setSlugLocked(true);
      setMessage({
        tone: "ok",
        text: status === "published" ? "Saved and published." : "Saved as a draft.",
      });
      if (!reportId) router.replace(`/admin/editor?id=${id}`);
    } catch (error) {
      const duplicate =
        error && typeof error === "object" && "code" in error && error.code === "23505";
      setMessage({
        tone: "error",
        text: duplicate
          ? "Another report already uses that page address. Change it and save again."
          : errorMessage(error),
      });
    } finally {
      setSaving(false);
    }
  }

  if (!loaded) {
    return <p className="font-mono text-sm text-muted">Loading the editor</p>;
  }

  const isPublished = form.status === "published";

  return (
    <div className="flex flex-col gap-10">
      <div className="flex flex-wrap items-end justify-between gap-4 border-b border-line pb-6">
        <div className="flex flex-col gap-2">
          <Link
            href="/admin"
            className="font-mono text-xs text-muted underline underline-offset-4"
          >
            All reports
          </Link>
          <h1 className="display text-5xl md:text-6xl">
            {reportId ? "Edit report" : "New report"}
          </h1>
        </div>
        <div className="flex flex-wrap items-center gap-2">
          <span
            className={`rounded-lg px-2.5 py-1 font-mono text-xs ${
              isPublished ? "bg-accent text-on-accent" : "border border-line text-muted"
            }`}
          >
            {isPublished ? "Published" : "Draft"}
          </span>
          {isPublished && (
            <Link href={`/reports/${form.slug}`} className={quietButton}>
              View page
            </Link>
          )}
          <button
            type="button"
            disabled={saving}
            onClick={() => save("draft")}
            className={quietButton}
          >
            {isPublished ? "Unpublish" : "Save draft"}
          </button>
          <button
            type="button"
            disabled={saving}
            onClick={() => save("published")}
            className={primaryButton}
          >
            {saving ? "Saving" : isPublished ? "Save changes" : "Publish"}
          </button>
        </div>
      </div>

      {message && (
        <p
          role={message.tone === "error" ? "alert" : "status"}
          className={`rounded-2xl border p-4 text-sm ${
            message.tone === "error" ? "border-ink bg-card" : "border-accent bg-accent-tint"
          }`}
        >
          {message.text}
        </p>
      )}

      <section className="flex flex-col gap-6 rounded-3xl border border-line bg-card/60 p-5 sm:p-8">
        <h2 className="font-mono text-xs text-accent">{"// DETAILS"}</h2>

        <label className="flex flex-col gap-2">
          <span className={labelClass}>Title</span>
          <input
            value={form.title}
            onChange={(event) => changeTitle(event.target.value)}
            className={inputClass}
          />
        </label>

        <div className="grid grid-cols-[repeat(auto-fit,minmax(min(240px,100%),1fr))] gap-6">
          <div className="flex flex-col gap-2">
            <label htmlFor="course" className={labelClass}>
              Course
            </label>
            {newCourse === null ? (
              <div className="flex gap-2">
                <select
                  id="course"
                  value={form.courseId}
                  onChange={(event) => update("courseId", event.target.value)}
                  className={inputClass}
                >
                  {courses.length === 0 && <option value="">No courses yet</option>}
                  {courses.map((course) => (
                    <option key={course.id} value={course.id}>
                      {course.name}
                    </option>
                  ))}
                </select>
                <button
                  type="button"
                  onClick={() => setNewCourse("")}
                  className={`${quietButton} shrink-0 px-4`}
                >
                  New
                </button>
              </div>
            ) : (
              <div className="flex gap-2">
                <input
                  id="course"
                  autoFocus
                  placeholder="Course name"
                  value={newCourse}
                  onChange={(event) => setNewCourse(event.target.value)}
                  className={inputClass}
                />
                <button
                  type="button"
                  onClick={addCourse}
                  className={`${primaryButton} shrink-0 px-4`}
                >
                  Add
                </button>
                <button
                  type="button"
                  onClick={() => setNewCourse(null)}
                  className={`${quietButton} shrink-0 px-4`}
                >
                  Cancel
                </button>
              </div>
            )}
          </div>

          <label className="flex flex-col gap-2">
            <span className={labelClass}>Label</span>
            <input
              placeholder="Practicum 08"
              value={form.label}
              onChange={(event) => update("label", event.target.value)}
              className={inputClass}
            />
          </label>

          <label className="flex flex-col gap-2">
            <span className={labelClass}>Number</span>
            <input
              inputMode="numeric"
              placeholder="8"
              value={form.number}
              onChange={(event) => update("number", event.target.value.replace(/\D/g, ""))}
              className={inputClass}
            />
            <span className="text-xs text-muted">
              Orders reports inside a course; the highest comes first.
            </span>
          </label>
        </div>

        <label className="flex flex-col gap-2">
          <span className={labelClass}>Page address</span>
          <input
            value={form.slug}
            onChange={(event) => {
              setSlugLocked(true);
              update("slug", event.target.value);
            }}
            className={`${inputClass} font-mono text-sm`}
          />
          <span className="text-xs text-muted">
            The report opens at /reports/{form.slug || "page-address"}
          </span>
        </label>

        <label className="flex flex-col gap-2">
          <span className={labelClass}>Summary</span>
          <textarea
            rows={3}
            value={form.summary}
            onChange={(event) => update("summary", event.target.value)}
            className={`${inputClass} py-3 leading-relaxed`}
          />
          <span className="text-xs text-muted">
            One or two sentences, shown under the title and on the home page.
          </span>
        </label>

        <div className="flex flex-col gap-2">
          <span className={labelClass}>Cover picture</span>
          <div className="flex flex-wrap items-center gap-4">
            {form.coverUrl && (
              // A plain img: the cover can come from any address the admin pasted in.
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={form.coverUrl}
                alt="Current cover"
                className="h-24 w-36 rounded-xl border border-line object-cover"
              />
            )}
            <button
              type="button"
              onClick={() => coverInput.current?.click()}
              className={quietButton}
            >
              {form.coverUrl ? "Replace picture" : "Upload picture"}
            </button>
            {form.coverUrl && (
              <button
                type="button"
                onClick={() => update("coverUrl", "")}
                className={quietButton}
              >
                Remove
              </button>
            )}
            <input
              ref={coverInput}
              type="file"
              accept="image/*"
              className="hidden"
              aria-label="Choose a cover picture"
              onChange={(event) => changeCover(event.target.files?.[0])}
            />
          </div>
          <span className="text-xs text-muted">
            Shown when this is the latest report on the home page.
          </span>
        </div>

        <label className="flex flex-col gap-2">
          <span className={labelClass}>Link on the old site</span>
          <input
            type="url"
            placeholder="https://"
            value={form.legacyUrl}
            onChange={(event) => update("legacyUrl", event.target.value)}
            className={inputClass}
          />
          <span className="text-xs text-muted">
            Used only while the report has no chapters here.
          </span>
        </label>
      </section>

      <section className="flex flex-col gap-6">
        <div className="flex flex-wrap items-end justify-between gap-4">
          <h2 className="display text-4xl">Chapters</h2>
          <span className="font-mono text-xs text-muted">
            Each chapter becomes an entry in the report&apos;s contents list.
          </span>
        </div>

        {chapters.map((chapter, index) => (
          <div
            key={chapter.id}
            className="flex flex-col gap-4 rounded-3xl border border-line bg-card/60 p-4 sm:p-6"
          >
            <div className="flex flex-wrap items-center gap-2">
              <span className="flex size-10 shrink-0 items-center justify-center rounded-xl bg-accent font-mono text-[13px] text-on-accent">
                {String(index + 1).padStart(2, "0")}
              </span>
              <input
                aria-label={`Chapter ${index + 1} title`}
                placeholder="Chapter title, e.g. A. Tujuan Praktikum"
                value={chapter.title}
                onChange={(event) => changeChapter(chapter.id, { title: event.target.value })}
                className={`${inputClass} min-w-0 flex-1 basis-60 font-medium`}
              />
              <button
                type="button"
                aria-label={`Move chapter ${index + 1} up`}
                disabled={index === 0}
                onClick={() => moveChapter(index, -1)}
                className={`${quietButton} px-4`}
              >
                Up
              </button>
              <button
                type="button"
                aria-label={`Move chapter ${index + 1} down`}
                disabled={index === chapters.length - 1}
                onClick={() => moveChapter(index, 1)}
                className={`${quietButton} px-4`}
              >
                Down
              </button>
              <button
                type="button"
                aria-label={`Remove chapter ${index + 1}`}
                onClick={() =>
                  setChapters((current) => current.filter((item) => item.id !== chapter.id))
                }
                className={`${quietButton} px-4`}
              >
                Remove
              </button>
            </div>
            <RichEditor
              initialContent={chapter.content}
              onChange={(content) => changeChapter(chapter.id, { content })}
              onUpload={uploadPicture}
            />
          </div>
        ))}

        <button
          type="button"
          onClick={() =>
            setChapters((current) => [
              ...current,
              { id: crypto.randomUUID(), title: "", content: "" },
            ])
          }
          className={`${quietButton} self-start`}
        >
          Add chapter
        </button>
      </section>
    </div>
  );
}
