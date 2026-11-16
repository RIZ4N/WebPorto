import type { Metadata } from "next";
import { ReportRow } from "@/components/report-row";
import { SectionHeading } from "@/components/section-heading";
import { getReports, groupByCourse } from "@/lib/data";

export const metadata: Metadata = {
  title: "Reports",
  description: "Practicum lab reports, grouped by course.",
};

export default async function ReportsPage() {
  const reports = await getReports();

  return (
    <div className="mx-auto flex max-w-[1240px] flex-col gap-14 px-5 pt-12 pb-16 sm:px-8 md:pt-16">
      <SectionHeading
        as="h1"
        number={String(reports.length)}
        title="Reports"
        description="Practicum write-ups from my Informatics coursework, grouped by course, newest first."
      />

      {groupByCourse(reports).map(({ course, items }) => (
        <section key={course} className="flex flex-col gap-4">
          <div className="flex items-baseline justify-between gap-6">
            <h2 className="display text-4xl">{course}</h2>
            <span className="font-mono text-xs text-muted">
              {items.length} {items.length === 1 ? "report" : "reports"}
            </span>
          </div>
          <div className="flex flex-col gap-3">
            {items.map((report) => (
              <ReportRow key={report.id} report={report} />
            ))}
          </div>
        </section>
      ))}
    </div>
  );
}
