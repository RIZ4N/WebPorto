import Link from "next/link";
import { ThemeToggle } from "./theme-toggle";

const links = [
  { href: "/", label: "Home" },
  { href: "/reports", label: "Reports" },
  { href: "/#projects", label: "Projects" },
  { href: "/#about", label: "About" },
  { href: "/#contact", label: "Contact" },
];

export function SiteHeader() {
  return (
    <header className="sticky top-0 z-20 border-b border-line bg-ground/90 backdrop-blur">
      <div className="mx-auto flex max-w-[1240px] flex-wrap items-center justify-between gap-x-8 gap-y-1 px-5 py-3 sm:px-8 md:py-4">
        <Link
          href="/"
          className="font-serif text-2xl font-medium tracking-tight text-ink"
        >
          Rizan Oesvan
        </Link>
        <div className="md:order-3">
          <ThemeToggle />
        </div>
        <nav
          aria-label="Main"
          className="-mx-1 flex w-full items-center gap-x-4 overflow-x-auto px-1 sm:gap-x-6 md:order-2 md:ml-auto md:w-auto md:gap-x-9"
        >
          {links.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="flex min-h-11 shrink-0 items-center text-[15px] font-medium text-ink transition-colors hover:text-accent"
            >
              {link.label}
            </Link>
          ))}
        </nav>
      </div>
    </header>
  );
}
