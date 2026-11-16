const contacts = [
  { href: "mailto:rizanoesvan@gmail.com", label: "Email" },
  { href: "https://github.com/RIZ4N", label: "GitHub" },
  { href: "https://www.instagram.com/rizanoesvan/", label: "Instagram" },
];

export function SiteFooter() {
  return (
    <footer id="contact" className="border-t border-line">
      <div className="mx-auto flex max-w-[1240px] flex-col gap-10 px-5 py-16 sm:px-8 md:flex-row md:items-end md:justify-between">
        <div className="flex flex-col gap-4">
          <p className="text-[13px] font-semibold tracking-[0.12em] text-accent">
            CONTACT
          </p>
          <p className="max-w-xl font-serif text-4xl leading-tight tracking-tight md:text-5xl">
            Want to work together or ask about a report?{" "}
            <a
              href="mailto:rizanoesvan@gmail.com"
              className="text-accent italic underline decoration-1 underline-offset-8"
            >
              Write to me.
            </a>
          </p>
        </div>
        <ul className="flex flex-wrap gap-x-8 gap-y-1">
          {contacts.map((contact) => (
            <li key={contact.label}>
              <a
                href={contact.href}
                className="flex min-h-11 items-center text-[15px] font-medium text-ink transition-colors hover:text-accent"
              >
                {contact.label}
              </a>
            </li>
          ))}
        </ul>
      </div>
      <div className="border-t border-line">
        <p className="mx-auto max-w-[1240px] px-5 py-6 text-sm text-muted sm:px-8">
          © 2026 Rizan Oesvan Idrati · Informatics, Universitas Andalas
        </p>
      </div>
    </footer>
  );
}
