import type { Metadata } from "next";
import { ReportRow } from "@/components/report-row";
import { SectionHeading } from "@/components/section-heading";
import { courses, reports } from "@/lib/content";

export const metadata: Metadata = {
  title: "Reports",
  description: "Practicum lab reports, grouped by course.",
};

export default function ReportsPage() {
  return (
    <div className="mx-auto flex max-w-[1240px] flex-col gap-14 px-5 pt-12 pb-16 sm:px-8 md:pt-16">
      <SectionHeading
        as="h1"
        number={String(reports.length)}
        title="Reports"
        description="Practicum write-ups from my Informatics coursework, grouped by course, newest first."
      />

      {courses.map((course) => {
        const items = reports.filter((report) => report.course === course);
        return (
          <section key={course} className="flex flex-col gap-4">
            <div className="flex items-baseline justify-between gap-6">
              <h2 className="display text-4xl">{course}</h2>
              <span className="font-mono text-xs text-muted">
                {items.length} reports
              </span>
            </div>
            <div className="flex flex-col gap-3">
              {items.map((report) => (
                <ReportRow key={report.href} report={report} />
              ))}
            </div>
          </section>
        );
      })}
    </div>
  );
}
