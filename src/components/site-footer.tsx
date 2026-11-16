import Link from "next/link";
import { contact } from "@/lib/content";
import { ContactForm } from "./contact-form";

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

const quietLinks = [
  { href: `mailto:${contact.email}`, label: contact.email },
  { href: contact.github, label: "GitHub" },
  { href: contact.instagram, label: "Instagram" },
];

export function SiteFooter() {
  return (
    <footer id="contact" className="px-3 pt-16 pb-3 sm:px-6 sm:pb-6 md:pt-24">
      <div className="mx-auto flex max-w-[1240px] flex-wrap items-center gap-x-16 gap-y-10 rounded-3xl bg-accent px-6 py-10 text-on-accent sm:px-12 sm:py-14">
        <div className="flex min-w-0 flex-1 basis-[420px] flex-col items-start gap-8">
          <p className="font-mono text-[13px]">{"// CONTACT"}</p>
          <p className="display text-[clamp(3rem,7.4vw,6.5rem)]">
            Got a question?
            <br />
            Say hi.
          </p>
          <a
            href={contact.linkedin}
            className="flex min-h-14 items-center gap-3 rounded-2xl bg-on-accent px-6 font-mono text-[15px] font-medium text-accent transition-transform hover:-translate-y-0.5"
          >
            Connect on LinkedIn
            <Arrow />
          </a>
          <ul className="flex flex-wrap gap-x-8 gap-y-1">
            {quietLinks.map((link) => (
              <li key={link.label}>
                <a
                  href={link.href}
                  className="flex min-h-11 items-center font-mono text-[14px] underline decoration-1 underline-offset-4"
                >
                  {link.label}
                </a>
              </li>
            ))}
          </ul>
        </div>
        <div className="min-w-0 flex-1 basis-[420px]">
          <ContactForm />
        </div>
      </div>
      <div className="mx-auto flex max-w-[1240px] items-center justify-between gap-4 px-2 pt-2">
        <p className="font-mono text-xs text-muted">
          © 2026 Rizan Oesvan Idrati · Informatics, Universitas Andalas
        </p>
        {/* Quiet way in for the site owner: looks like one of the diamond marks used elsewhere. */}
        <Link
          href="/admin"
          aria-label="Admin sign in"
          className="group flex min-h-11 min-w-11 items-center justify-end gap-2"
        >
          <span className="font-mono text-xs text-muted opacity-0 transition-opacity duration-300 group-hover:opacity-100 group-focus-visible:opacity-100">
            admin
          </span>
          <span
            aria-hidden="true"
            className="size-2 rotate-45 bg-line transition-[transform,background-color] duration-500 group-hover:rotate-[225deg] group-hover:scale-150 group-hover:bg-accent group-focus-visible:rotate-[225deg] group-focus-visible:scale-150 group-focus-visible:bg-accent"
          />
        </Link>
      </div>
    </footer>
  );
}
