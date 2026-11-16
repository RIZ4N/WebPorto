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
    <div className="mx-auto flex max-w-[1240px] flex-col gap-16 px-5 pt-14 pb-24 sm:px-8 md:pt-20">
      <div className="flex flex-col gap-6">
        <SectionHeading as="h1" eyebrow="Lab reports" title="Practicum write-ups" />
        <p className="max-w-[560px] text-lg leading-[1.7] text-muted">
          {reports.length} reports from my Informatics coursework, grouped by
          course and listed newest first.
        </p>
      </div>

      {courses.map((course) => {
        const items = reports.filter((report) => report.course === course);
        return (
          <section key={course} className="flex flex-col gap-6">
            <div className="flex items-baseline justify-between gap-6 border-b border-ink pb-4">
              <h2 className="font-serif text-3xl leading-tight">{course}</h2>
              <span className="text-sm text-muted">
                {items.length} reports
              </span>
            </div>
            <div>
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
