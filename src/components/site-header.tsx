import Link from "next/link";
import { ThemeToggle } from "./theme-toggle";

const links = [
  { href: "/", label: "Home" },
  { href: "/#about", label: "About" },
  { href: "/reports", label: "Reports" },
  { href: "/#projects", label: "Projects" },
  { href: "/#gallery", label: "Gallery" },
];

export function SiteHeader() {
  return (
    <header className="sticky top-0 z-20 px-3 pt-3 sm:px-6">
      <div className="mx-auto flex max-w-[1240px] flex-wrap items-center gap-x-6 gap-y-1 rounded-2xl border border-line bg-card/90 px-3 py-2 backdrop-blur sm:px-4">
        <Link
          href="/"
          className="flex items-center gap-3"
          aria-label="Rizan Oesvan Idrati, home"
        >
          <span className="display flex size-10 items-center justify-center rounded-xl bg-ink text-2xl text-ground">
            R
          </span>
          <span className="hidden items-center gap-2 font-mono text-xs text-muted lg:flex">
            <span aria-hidden="true" className="size-2 rounded-full bg-accent" />
            Informatics · Universitas Andalas
          </span>
        </Link>

        <div className="ml-auto flex items-center gap-2 md:order-3 md:ml-0">
          <ThemeToggle />
          <a
            href="#contact"
            className="flex min-h-11 items-center rounded-xl bg-accent px-4 font-mono text-[13px] font-medium text-on-accent transition-transform hover:-translate-y-0.5"
          >
            Say hi
          </a>
        </div>

        <nav
          aria-label="Main"
          className="flex w-full items-center gap-x-5 overflow-x-auto md:order-2 md:mx-auto md:w-auto md:gap-x-7"
        >
          {links.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="flex min-h-11 shrink-0 items-center font-mono text-[13px] text-ink transition-colors hover:text-accent"
            >
              {link.label}
            </Link>
          ))}
        </nav>
      </div>
    </header>
  );
}
