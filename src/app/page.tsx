import Image from "next/image";
import Link from "next/link";
import { ReportRow } from "@/components/report-row";
import { Reveal } from "@/components/reveal";
import { SectionHeading } from "@/components/section-heading";
import {
  courses,
  education,
  experience,
  projects,
  reports,
  stack,
} from "@/lib/content";
import profile from "../../public/images/profile.jpg";
import resepku from "../../public/images/reports/resepku-grid.jpg";

const featured = reports[0];
const moreReports = [reports[1], reports[2], reports[7], reports[8]];

const numbers = [
  { value: String(reports.length), label: "lab reports" },
  { value: String(courses.length), label: "courses" },
  { value: "2024", label: "class of" },
];

function Arrow() {
  return (
    <svg
      aria-hidden="true"
      width="18"
      height="18"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="1.8"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M7 17L17 7M8 7h9v9" />
    </svg>
  );
}

function step(i: number) {
  return { "--i": i } as React.CSSProperties;
}

export default function Home() {
  return (
    <>
      <section className="mx-auto flex max-w-[1240px] flex-col gap-8 px-5 pt-12 pb-14 sm:px-8 md:gap-10 md:pt-16 md:pb-20">
        <div
          className="rise flex flex-wrap justify-between gap-x-8 gap-y-1 font-mono text-[13px]"
          style={step(0)}
        >
          <span className="text-accent">{"// Hello, I'm"}</span>
          <span className="text-muted">Portfolio · 2026</span>
        </div>

        <h1
          className="display rise flex flex-wrap items-center gap-x-[0.18em] gap-y-1 text-[clamp(3.75rem,14.5vw,12rem)]"
          style={step(1)}
        >
          <span>Rizan</span>
          <span className="relative inline-block h-[0.76em] w-[0.6em] -rotate-6 overflow-hidden rounded-[0.12em] border-2 border-ink bg-card transition-transform duration-500 hover:rotate-3">
            <Image
              src={profile}
              alt="Portrait of Rizan Oesvan Idrati"
              fill
              priority
              sizes="160px"
              className="object-cover object-[center_22%]"
            />
          </span>
          <span>Oesvan</span>
          <span className="basis-full text-accent">Idrati</span>
        </h1>

        <div
          className="rise flex flex-wrap items-end justify-between gap-x-16 gap-y-8 border-t border-ink pt-8"
          style={step(2)}
        >
          <p className="max-w-[470px] font-mono text-[15px] leading-relaxed text-muted">
            Informatics student at Universitas Andalas, class of 2024. I build
            things for the web and mobile, and this is where I write them up.
          </p>
          <div className="flex flex-wrap gap-3">
            <Link
              href="/reports"
              className="flex min-h-14 items-center gap-3 rounded-2xl bg-accent px-6 font-mono text-[15px] font-medium text-on-accent transition-transform hover:-translate-y-0.5"
            >
              Read reports
              <Arrow />
            </Link>
            <Link
              href="/#projects"
              className="flex min-h-14 items-center rounded-2xl border border-ink px-6 font-mono text-[15px] font-medium text-ink transition-colors hover:bg-ink hover:text-ground"
            >
              See projects
            </Link>
          </div>
        </div>
      </section>

      <div className="marquee overflow-hidden bg-ink py-4 text-ground">
        <div className="marquee-track flex w-max">
          {[0, 1].map((copy) => (
            <ul
              key={copy}
              aria-hidden={copy === 1}
              className="display flex shrink-0 items-center gap-10 pr-10 text-3xl"
            >
              {[...stack, ...stack].map((item, index) => (
                <li key={`${item}-${index}`} className="flex items-center gap-10">
                  {item}
                  <span
                    aria-hidden="true"
                    className="size-2.5 rotate-45 bg-panel-accent"
                  />
                </li>
              ))}
            </ul>
          ))}
        </div>
      </div>

      <section className="px-3 pt-16 sm:px-6 md:pt-24">
        <Reveal>
          <div className="mx-auto flex max-w-[1240px] flex-col gap-10 overflow-hidden rounded-3xl bg-panel p-6 text-on-panel sm:p-12">
            <SectionHeading
              tone="panel"
              number="01"
              title="Latest report"
              description="The newest write-up from the lab, with a few earlier ones underneath."
            />
            <div className="flex flex-wrap items-center gap-x-16 gap-y-12">
              <div className="flex min-w-0 flex-1 basis-[420px] flex-col items-start gap-6">
                <p className="font-mono text-[13px] text-panel-accent uppercase">
                  {featured.course} · {featured.label}
                </p>
                <h3 className="display text-[clamp(2.25rem,4.6vw,4rem)]">
                  {featured.title}
                </h3>
                <p className="max-w-[440px] font-mono text-sm leading-relaxed text-panel-muted">
                  ResepKu, my recipe app in Flutter, gets list and grid views,
                  recipe photos, and bundled assets.
                </p>
                <a
                  href={featured.href}
                  className="flex min-h-14 items-center gap-3 rounded-2xl bg-panel-accent px-6 font-mono text-[15px] font-medium text-panel transition-transform hover:-translate-y-0.5"
                >
                  Read the report
                  <Arrow />
                </a>
              </div>
              <div className="min-w-0 flex-1 basis-[420px] px-2 pb-2">
                <Image
                  src={resepku}
                  alt="ResepKu app showing recipes in a two-column grid"
                  placeholder="blur"
                  sizes="(min-width: 1024px) 540px, 90vw"
                  className="w-full rotate-2 rounded-2xl border border-panel-line transition-transform duration-500 hover:rotate-0"
                />
              </div>
            </div>
          </div>
        </Reveal>

        <Reveal className="mx-auto flex max-w-[1240px] flex-col gap-3 pt-6">
          {moreReports.map((report) => (
            <ReportRow key={report.href} report={report} />
          ))}
          <Link
            href="/reports"
            className="mt-3 flex min-h-12 items-center gap-2 self-start font-mono text-sm font-medium text-accent underline decoration-1 underline-offset-[6px]"
          >
            View all {reports.length} reports
          </Link>
        </Reveal>
      </section>

      <section id="projects" className="px-5 pt-20 sm:px-8 md:pt-28">
        <Reveal className="mx-auto flex max-w-[1240px] flex-col gap-10">
          <SectionHeading
            number="02"
            title="Projects"
            description="A few things I've made so far, from interface concepts to things that run."
          />
          <div className="grid grid-cols-[repeat(auto-fit,minmax(min(280px,100%),1fr))] gap-5">
            {projects.map((project) => (
              <article
                key={project.title}
                className="group flex flex-col rounded-3xl border border-line bg-card p-3 transition-transform duration-300 hover:-translate-y-1.5 hover:-rotate-1"
              >
                <div className="overflow-hidden rounded-2xl">
                  <Image
                    src={project.image}
                    alt={`Screenshot of ${project.title}`}
                    width={1280}
                    height={800}
                    sizes="(min-width: 1024px) 380px, 90vw"
                    className="aspect-[16/10] w-full object-cover transition-transform duration-500 group-hover:scale-105"
                  />
                </div>
                <div className="flex flex-1 flex-col gap-3 px-3 pt-5 pb-3">
                  <h3 className="display text-4xl">{project.title}</h3>
                  <p className="text-[15px] text-muted">{project.description}</p>
                  <ul className="mt-auto flex flex-wrap gap-2 pt-2">
                    {project.tech.map((tech) => (
                      <li
                        key={tech}
                        className="rounded-lg bg-accent-tint px-2.5 py-1 font-mono text-xs text-ink"
                      >
                        {tech}
                      </li>
                    ))}
                  </ul>
                </div>
              </article>
            ))}
          </div>
        </Reveal>
      </section>

      <section id="about" className="px-5 pt-20 pb-12 sm:px-8 md:pt-28 md:pb-20">
        <Reveal className="mx-auto flex max-w-[1240px] flex-col gap-10">
          <SectionHeading
            number="03"
            title="About"
            description="Who's behind the reports."
          />
          <div className="flex flex-wrap gap-x-16 gap-y-12">
            <div className="flex-[0_1_300px] px-2">
              <Image
                src={profile}
                alt="Rizan standing in a garden"
                placeholder="blur"
                sizes="(min-width: 768px) 300px, 80vw"
                className="aspect-[4/5] w-full -rotate-3 rounded-3xl border-2 border-ink object-cover object-[center_20%] transition-transform duration-500 hover:rotate-0"
              />
            </div>
            <div className="flex min-w-0 flex-1 basis-[480px] flex-col gap-10">
              <p className="max-w-[640px] text-xl leading-relaxed">
                I&apos;m Rizan, an Informatics student at Universitas Andalas. I
                built this site as a place to show my work, my experience, and
                how I&apos;m progressing in design and web development.
              </p>
              <dl className="flex flex-wrap gap-x-14 gap-y-6">
                {numbers.map((item) => (
                  <div key={item.label} className="flex flex-col-reverse">
                    <dt className="font-mono text-xs text-muted">
                      {item.label}
                    </dt>
                    <dd className="display text-7xl text-accent">
                      {item.value}
                    </dd>
                  </div>
                ))}
              </dl>
              <div className="grid grid-cols-[repeat(auto-fit,minmax(min(260px,100%),1fr))] gap-x-12 gap-y-10">
                <Timeline title="Education" items={education} />
                <Timeline title="Experience" items={experience} />
              </div>
            </div>
          </div>
        </Reveal>
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
      <h3 className="border-b border-ink pb-3 font-mono text-xs text-muted uppercase">
        {`// ${title}`}
      </h3>
      <ul>
        {items.map((item) => (
          <li
            key={item.place}
            className="flex flex-col gap-0.5 border-b border-line py-4"
          >
            <span className="text-lg leading-snug font-medium">{item.place}</span>
            <span className="text-[15px] text-muted">{item.detail}</span>
            <span className="font-mono text-xs text-muted">{item.period}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
