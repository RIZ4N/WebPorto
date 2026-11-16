import Link from "next/link";
import type { ReportSummary } from "@/lib/data";

const rowClass =
  "group flex flex-wrap items-center gap-x-6 gap-y-2 rounded-2xl border border-line bg-card px-5 py-4 text-ink transition-[transform,border-color] duration-300 hover:-translate-y-0.5 hover:border-accent sm:px-6";

export function ReportRow({ report }: { report: ReportSummary }) {
  const content = (
    <>
      <span className="w-full font-mono text-xs text-muted uppercase sm:w-28">
        {report.label}
      </span>
      <span className="min-w-0 flex-1 basis-72 text-lg leading-snug font-medium">
        {report.title}
      </span>
      <span className="rounded-lg bg-accent-tint px-2.5 py-1 font-mono text-xs text-ink">
        {report.course}
      </span>
      <span
        aria-hidden="true"
        className="flex size-9 items-center justify-center rounded-xl border border-line transition-colors group-hover:border-accent group-hover:bg-accent group-hover:text-on-accent"
      >
        <svg
          width="16"
          height="16"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="1.8"
          strokeLinecap="round"
          strokeLinejoin="round"
        >
          <path d="M7 17L17 7M8 7h9v9" />
        </svg>
      </span>
    </>
  );

  // Reports not migrated yet still open their page on the old site.
  return report.external ? (
    <a href={report.href} className={rowClass}>
      {content}
    </a>
  ) : (
    <Link href={report.href} className={rowClass}>
      {content}
    </Link>
  );
}
