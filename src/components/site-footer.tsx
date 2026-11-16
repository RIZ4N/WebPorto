const contacts = [
  { href: "https://github.com/RIZ4N", label: "GitHub" },
  { href: "https://www.instagram.com/rizanoesvan/", label: "Instagram" },
];

export function SiteFooter() {
  return (
    <footer id="contact" className="px-3 pt-8 pb-3 sm:px-6 sm:pb-6">
      <div className="mx-auto flex max-w-[1240px] flex-col gap-12 rounded-3xl bg-accent px-6 py-12 text-on-accent sm:px-12 sm:py-16">
        <p className="font-mono text-[13px]">{"// CONTACT"}</p>
        <p className="display text-[clamp(3rem,10vw,8.5rem)]">
          Got a question?
          <br />
          Say hi.
        </p>
        <div className="flex flex-wrap items-center justify-between gap-x-10 gap-y-6">
          <a
            href="mailto:rizanoesvan@gmail.com"
            className="flex min-h-14 items-center gap-3 rounded-2xl bg-on-accent px-6 font-mono text-[15px] font-medium text-accent transition-transform hover:-translate-y-0.5"
          >
            rizanoesvan@gmail.com
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
          </a>
          <ul className="flex flex-wrap gap-x-8 gap-y-1">
            {contacts.map((contact) => (
              <li key={contact.label}>
                <a
                  href={contact.href}
                  className="flex min-h-11 items-center font-mono text-[14px] underline decoration-1 underline-offset-4"
                >
                  {contact.label}
                </a>
              </li>
            ))}
          </ul>
        </div>
      </div>
      <p className="mx-auto max-w-[1240px] px-2 pt-5 font-mono text-xs text-muted">
        © 2026 Rizan Oesvan Idrati · Informatics, Universitas Andalas
      </p>
    </footer>
  );
}
