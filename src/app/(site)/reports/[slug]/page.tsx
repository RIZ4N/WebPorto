import Link from "next/link";
import { notFound } from "next/navigation";
import { Suspense } from "react";
import { getReport } from "@/lib/data";

export default function ReportPage({ params }: PageProps<"/reports/[slug]">) {
  return (
    <Suspense fallback={<ReportSkeleton />}>
      <Report params={params} />
    </Suspense>
  );
}

async function Report({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const report = await getReport(slug);
  if (!report) notFound();

  return (
    <article className="mx-auto flex max-w-[1240px] flex-col gap-12 px-5 pt-12 pb-16 sm:px-8 md:pt-16">
      <title>{`${report.title} · Rizan Oesvan Idrati`}</title>

      <header className="flex flex-col gap-6 border-b border-line pb-10">
        <nav
          aria-label="Breadcrumb"
          className="flex flex-wrap items-center gap-2 font-mono text-xs text-muted"
        >
          <Link href="/reports" className="hover:text-accent">
            Reports
          </Link>
          <span aria-hidden="true">/</span>
          <span>{report.course}</span>
        </nav>
        <p className="font-mono text-[13px] text-accent uppercase">
          {report.course} · {report.label}
        </p>
        <h1 className="display max-w-[980px] text-[clamp(2.5rem,6.5vw,5.5rem)]">
          {report.title}
        </h1>
        {report.summary && (
          <p className="max-w-[640px] text-lg leading-relaxed text-muted">
            {report.summary}
          </p>
        )}
      </header>

      {report.sections.length === 0 ? (
        <div className="flex flex-col items-start gap-5 rounded-3xl border border-line bg-card p-8">
          <p className="max-w-[560px] text-lg">
            The chapters of this report haven&apos;t been moved here yet.
          </p>
          {report.legacyUrl && (
            <a
              href={report.legacyUrl}
              className="flex min-h-12 items-center rounded-2xl bg-accent px-5 font-mono text-sm font-medium text-on-accent"
            >
              Read it on the old site
            </a>
          )}
        </div>
      ) : (
        <div className="flex flex-wrap items-start gap-x-16 gap-y-10">
          <nav
            aria-label="Contents"
            className="flex flex-[1_1_220px] flex-col gap-1 rounded-3xl border border-line bg-card p-5 md:sticky md:top-28 md:max-w-[280px]"
          >
            <p className="pb-2 font-mono text-xs text-muted uppercase">
              {"// Contents"}
            </p>
            {report.sections.map((section, index) => (
              <a
                key={section.id}
                href={`#chapter-${index + 1}`}
                className="flex min-h-11 items-center rounded-xl px-3 text-[15px] leading-snug text-ink transition-colors hover:bg-accent-tint"
              >
                {section.title}
              </a>
            ))}
          </nav>

          <div className="flex min-w-0 flex-[999_1_560px] flex-col gap-16">
            {report.sections.map((section, index) => (
              <section
                key={section.id}
                id={`chapter-${index + 1}`}
                className="flex max-w-[760px] flex-col gap-6"
              >
                <h2 className="display border-b border-line pb-4 text-4xl md:text-5xl">
                  {section.title}
                </h2>
                {/* Chapter HTML is written only by the site admin in the editor. */}
                <div
                  className="report-body"
                  dangerouslySetInnerHTML={{ __html: section.content }}
                />
              </section>
            ))}
            <Link
              href="/reports"
              className="flex min-h-12 items-center self-start font-mono text-sm font-medium text-accent underline decoration-1 underline-offset-[6px]"
            >
              Back to all reports
            </Link>
          </div>
        </div>
      )}
    </article>
  );
}

function ReportSkeleton() {
  return (
    <div
      aria-busy="true"
      className="mx-auto flex max-w-[1240px] flex-col gap-6 px-5 pt-12 pb-16 sm:px-8 md:pt-16"
    >
      <div className="h-4 w-40 rounded bg-line" />
      <div className="h-16 w-3/4 rounded-xl bg-line" />
      <div className="h-16 w-1/2 rounded-xl bg-line" />
      <p className="sr-only">Loading report</p>
    </div>
  );
}
