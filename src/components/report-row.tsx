import type { Report } from "@/lib/content";

export function ReportRow({ report }: { report: Report }) {
  return (
    <a
      href={report.href}
      className="group flex flex-wrap items-center gap-x-8 gap-y-2 border-b border-line py-6 text-ink"
    >
      <span className="w-full text-[13px] font-medium tracking-[0.06em] text-muted uppercase sm:w-32">
        {report.label}
      </span>
      <span className="min-w-0 flex-1 basis-72 font-serif text-2xl leading-snug transition-colors group-hover:text-accent">
        {report.title}
      </span>
      <span className="rounded-full bg-accent-tint px-3 py-1 text-[13px] font-medium text-accent">
        {report.course}
      </span>
      <svg
        aria-hidden="true"
        className="transition-transform duration-300 group-hover:translate-x-1.5 group-hover:text-accent"
        width="20"
        height="20"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="1.6"
        strokeLinecap="round"
        strokeLinejoin="round"
      >
        <path d="M5 12h14M13 6l6 6-6 6" />
      </svg>
    </a>
  );
}
