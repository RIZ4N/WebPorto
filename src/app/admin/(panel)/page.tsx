"use client";

import Link from "next/link";
import { useCallback, useEffect, useState } from "react";
import { refreshContent } from "@/app/actions";
import { errorMessage, primaryButton } from "@/components/admin/ui";
import { createClient } from "@/lib/supabase";

type Row = {
  id: string;
  title: string;
  label: string;
  status: "draft" | "published";
  updated_at: string;
  course: { name: string } | null;
  sections: { count: number }[];
};

async function fetchRows(): Promise<{ rows: Row[] | null; error: string | null }> {
  const { data, error } = await createClient()
    .from("reports")
    .select(
      "id, title, label, status, updated_at, course:courses(name), sections:report_sections(count)",
    )
    .order("updated_at", { ascending: false });
  if (error) return { rows: null, error: errorMessage(error) };
  return { rows: data as unknown as Row[], error: null };
}

export default function AdminReportsPage() {
  const [rows, setRows] = useState<Row[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [confirming, setConfirming] = useState<string | null>(null);

  const apply = useCallback((result: Awaited<ReturnType<typeof fetchRows>>) => {
    setError(result.error);
    if (result.rows) setRows(result.rows);
  }, []);

  useEffect(() => {
    let cancelled = false;
    fetchRows().then((result) => {
      if (!cancelled) apply(result);
    });
    return () => {
      cancelled = true;
    };
  }, [apply]);

  async function remove(id: string) {
    const { error } = await createClient().from("reports").delete().eq("id", id);
    setConfirming(null);
    if (error) {
      setError(errorMessage(error));
      return;
    }
    await refreshContent();
    apply(await fetchRows());
  }

  return (
    <div className="flex flex-col gap-8">
      <div className="flex flex-wrap items-end justify-between gap-4 border-b border-line pb-6">
        <h1 className="display text-6xl">Reports</h1>
        <Link href="/admin/editor" className={primaryButton}>
          New report
        </Link>
      </div>

      {error && (
        <p role="alert" className="rounded-2xl border border-line bg-card p-4 text-sm">
          {error}
        </p>
      )}

      {rows === null && !error && (
        <p className="font-mono text-sm text-muted">Loading reports</p>
      )}

      {rows?.length === 0 && (
        <p className="rounded-2xl border border-line bg-card p-6">
          No reports yet. Start with “New report”.
        </p>
      )}

      <ul className="flex flex-col gap-3">
        {rows?.map((row) => {
          const chapters = row.sections[0]?.count ?? 0;
          return (
            <li
              key={row.id}
              className="flex flex-wrap items-center gap-x-5 gap-y-3 rounded-2xl border border-line bg-card px-5 py-4"
            >
              <div className="flex min-w-0 flex-1 basis-72 flex-col gap-1">
                <span className="text-lg leading-snug font-medium">{row.title}</span>
                <span className="font-mono text-xs text-muted">
                  {row.course?.name ?? "No course"}
                  {row.label ? ` · ${row.label}` : ""} · {chapters}{" "}
                  {chapters === 1 ? "chapter" : "chapters"}
                </span>
              </div>
              <span
                className={`rounded-lg px-2.5 py-1 font-mono text-xs ${
                  row.status === "published"
                    ? "bg-accent text-on-accent"
                    : "border border-line text-muted"
                }`}
              >
                {row.status === "published" ? "Published" : "Draft"}
              </span>
              <div className="flex items-center gap-2">
                <Link
                  href={`/admin/editor?id=${row.id}`}
                  className="flex min-h-11 items-center rounded-xl border border-line px-4 font-mono text-[13px] hover:border-accent hover:text-accent"
                >
                  Edit
                </Link>
                {confirming === row.id ? (
                  <>
                    <button
                      type="button"
                      onClick={() => remove(row.id)}
                      className="flex min-h-11 cursor-pointer items-center rounded-xl bg-ink px-4 font-mono text-[13px] text-ground"
                    >
                      Yes, delete
                    </button>
                    <button
                      type="button"
                      onClick={() => setConfirming(null)}
                      className="flex min-h-11 cursor-pointer items-center rounded-xl border border-line px-4 font-mono text-[13px]"
                    >
                      Keep
                    </button>
                  </>
                ) : (
                  <button
                    type="button"
                    onClick={() => setConfirming(row.id)}
                    className="flex min-h-11 cursor-pointer items-center rounded-xl border border-line px-4 font-mono text-[13px] hover:border-ink"
                  >
                    Delete
                  </button>
                )}
              </div>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
