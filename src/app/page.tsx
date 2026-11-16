import Image from "next/image";
import Link from "next/link";
import { ReportRow } from "@/components/report-row";
import { SectionHeading } from "@/components/section-heading";
import {
  education,
  experience,
  projects,
  reports,
  stack,
} from "@/lib/content";
import profile from "../../public/images/profile.jpg";

const latestReports = [reports[0], reports[1], reports[2], reports[7], reports[8]];

export default function Home() {
  return (
    <>
      <section className="mx-auto flex max-w-[1240px] flex-col gap-12 px-5 pt-12 pb-16 sm:px-8 md:gap-14 md:pt-14 md:pb-20">
        <div
          className="rise flex flex-wrap justify-between gap-x-8 gap-y-2 text-[13px] font-semibold tracking-[0.12em]"
          style={{ "--i": 0 } as React.CSSProperties}
        >
          <span className="text-accent">INFORMATICS · UNIVERSITAS ANDALAS</span>
          <span className="text-muted">PORTFOLIO · 2026</span>
        </div>

        <div className="flex flex-wrap items-end gap-x-[72px] gap-y-14">
          <div className="flex min-w-0 flex-1 basis-[520px] flex-col gap-12">
            <h1
              className="rise font-serif text-[clamp(2.75rem,8.4vw,7.5rem)] leading-[0.96] font-normal tracking-[-0.03em]"
              style={{ "--i": 1 } as React.CSSProperties}
            >
              <span className="block">Rizan Oesvan</span>
              <span className="block text-accent italic">Idrati</span>
            </h1>
            <div
              className="rise flex flex-wrap items-end gap-x-14 gap-y-8 border-t border-ink pt-8"
              style={{ "--i": 2 } as React.CSSProperties}
            >
              <p className="max-w-[400px] flex-1 basis-[300px] text-lg leading-[1.7] text-muted">
                Informatics student who builds for the web and mobile. This is
                where I keep my lab reports and the projects I&apos;ve worked on.
              </p>
              <Link
                href="/reports"
                className="group inline-flex min-h-14 items-center gap-4 rounded-full bg-accent py-0 pr-3 pl-7 font-semibold text-on-accent"
              >
                Read reports
                <span
                  aria-hidden="true"
                  className="flex size-9 items-center justify-center rounded-full bg-ground text-accent transition-transform duration-300 group-hover:translate-x-1"
                >
                  <svg
                    width="18"
                    height="18"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  >
                    <path d="M5 12h14M13 6l6 6-6 6" />
                  </svg>
                </span>
              </Link>
            </div>
          </div>

          <div
            className="rise flex min-w-60 flex-[0_1_380px] flex-col gap-3.5"
            style={{ "--i": 3 } as React.CSSProperties}
          >
            <div className="relative pt-7 pr-7">
              <div
                aria-hidden="true"
                className="absolute top-0 right-0 h-[70%] w-[62%] bg-accent"
              />
              <Image
                src={profile}
                alt="Portrait of Rizan Oesvan Idrati"
                priority
                placeholder="blur"
                sizes="(min-width: 768px) 380px, 90vw"
                className="relative aspect-[4/5] w-full object-cover object-[center_20%]"
              />
            </div>
            <span className="text-[13px] text-muted">
              S1 Informatika, 2024 to present
            </span>
          </div>
        </div>

        <ul
          className="rise flex flex-wrap items-center gap-x-7 gap-y-2 border-y border-line py-5 font-serif text-2xl italic md:text-[26px]"
          style={{ "--i": 4 } as React.CSSProperties}
        >
          {stack.map((item, index) => (
            <li key={item} className="flex items-center gap-x-7">
              {index > 0 && (
                <span
                  aria-hidden="true"
                  className="size-1.5 rounded-full bg-accent"
                />
              )}
              {item}
            </li>
          ))}
        </ul>
      </section>

      <section className="border-t border-line">
        <div className="mx-auto flex max-w-[1240px] flex-col gap-10 px-5 py-20 sm:px-8 md:py-24">
          <div className="flex flex-wrap items-end justify-between gap-6">
            <SectionHeading
              eyebrow="Lab reports"
              title="Latest practicum write-ups"
            />
            <Link
              href="/reports"
              className="flex min-h-11 items-center text-[15px] font-semibold text-accent underline decoration-1 underline-offset-[6px]"
            >
              View all {reports.length} reports
            </Link>
          </div>
          <div className="border-t border-line">
            {latestReports.map((report) => (
              <ReportRow key={report.href} report={report} />
            ))}
          </div>
        </div>
      </section>

      <section id="projects" className="border-t border-line bg-surface">
        <div className="mx-auto flex max-w-[1240px] flex-col gap-10 px-5 py-20 sm:px-8 md:py-24">
          <SectionHeading eyebrow="Projects" title="Things I've built" />
          <div className="grid grid-cols-[repeat(auto-fit,minmax(min(280px,100%),1fr))] gap-8">
            {projects.map((project) => (
              <article key={project.title} className="group flex flex-col gap-5">
                <div className="overflow-hidden border border-line bg-ground">
                  <Image
                    src={project.image}
                    alt={`Screenshot of ${project.title}`}
                    width={1280}
                    height={800}
                    sizes="(min-width: 1024px) 380px, 90vw"
                    className="aspect-[16/10] w-full object-cover transition-transform duration-500 group-hover:scale-[1.03]"
                  />
                </div>
                <div className="flex flex-col gap-2.5">
                  <h3 className="font-serif text-[26px] leading-tight font-medium">
                    {project.title}
                  </h3>
                  <p className="text-[15px] text-muted">{project.description}</p>
                  <p className="text-[13px] font-medium text-accent">
                    {project.tech.join(" · ")}
                  </p>
                </div>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section id="about" className="border-t border-line">
        <div className="mx-auto flex max-w-[1240px] flex-wrap gap-x-24 gap-y-12 px-5 py-20 sm:px-8 md:py-24">
          <div className="flex min-w-0 flex-1 basis-[420px] flex-col gap-8">
            <SectionHeading eyebrow="About" title="A little about me" />
            <p className="max-w-[520px] text-lg leading-[1.7] text-muted">
              I&apos;m Rizan, an Informatics student at Universitas Andalas, class
              of 2024. I built this site as a place to show my work, my
              experience, and how I&apos;m progressing in design and web
              development.
            </p>
          </div>
          <div className="flex min-w-0 flex-1 basis-[420px] flex-col gap-10">
            <Timeline title="Education" items={education} />
            <Timeline title="Experience" items={experience} />
          </div>
        </div>
      </section>
    </>
  );
}

function Timeline({
  title,
  items,
}: {
  title: string;
  items: { place: string; detail: string; period: string }[];
}) {
  return (
    <div className="flex flex-col">
      <h3 className="border-b border-ink pb-3 text-[13px] font-semibold tracking-[0.12em] text-muted uppercase">
        {title}
      </h3>
      <ul>
        {items.map((item) => (
          <li
            key={item.place}
            className="flex flex-wrap items-baseline justify-between gap-x-8 gap-y-1 border-b border-line py-4"
          >
            <span className="flex flex-col">
              <span className="font-serif text-[22px] leading-snug">
                {item.place}
              </span>
              <span className="text-[15px] text-muted">{item.detail}</span>
            </span>
            <span className="text-sm text-muted">{item.period}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
