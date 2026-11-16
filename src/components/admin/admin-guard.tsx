"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { ThemeToggle } from "@/components/theme-toggle";
import { createClient } from "@/lib/supabase";
import { quietButton } from "./ui";

type State =
  | { kind: "checking" }
  | { kind: "ready"; email: string }
  | { kind: "not-admin"; userId: string; email: string };

/** Shows the panel only to a signed-in account that is listed in the admins table. */
export function AdminGuard({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const [state, setState] = useState<State>({ kind: "checking" });

  useEffect(() => {
    let cancelled = false;
    async function check() {
      const supabase = createClient();
      const { data } = await supabase.auth.getSession();
      const user = data.session?.user;
      if (!user) {
        router.replace("/admin/login");
        return;
      }
      const { data: row } = await supabase
        .from("admins")
        .select("user_id")
        .eq("user_id", user.id)
        .maybeSingle();
      if (cancelled) return;
      setState(
        row
          ? { kind: "ready", email: user.email ?? "" }
          : { kind: "not-admin", userId: user.id, email: user.email ?? "" },
      );
    }
    check();
    return () => {
      cancelled = true;
    };
  }, [router]);

  async function signOut() {
    await createClient().auth.signOut();
    router.replace("/admin/login");
  }

  if (state.kind === "checking") {
    return (
      <p className="px-5 py-16 text-center font-mono text-sm text-muted">
        Checking your sign-in
      </p>
    );
  }

  if (state.kind === "not-admin") {
    return (
      <div className="mx-auto flex max-w-[640px] flex-col gap-5 px-5 py-16">
        <h1 className="display text-5xl">Not an admin yet</h1>
        <p>
          You&apos;re signed in as {state.email}, but this account isn&apos;t
          allowed to edit the site. Run this line in Supabase &gt; SQL Editor,
          then reload this page:
        </p>
        <pre className="overflow-x-auto rounded-2xl bg-panel p-4 font-mono text-[13px] text-on-panel">
          {`insert into public.admins (user_id)\nvalues ('${state.userId}');`}
        </pre>
        <button type="button" onClick={signOut} className={`${quietButton} self-start`}>
          Sign out
        </button>
      </div>
    );
  }

  return (
    <>
      <header className="sticky top-0 z-20 px-3 pt-3 sm:px-6">
        <div className="mx-auto flex max-w-[1100px] flex-wrap items-center gap-x-5 gap-y-1 rounded-2xl border border-line bg-card/90 px-3 py-2 backdrop-blur sm:px-4">
          <Link href="/admin" className="flex items-center gap-3">
            <span className="display flex size-10 items-center justify-center rounded-xl bg-ink text-2xl text-ground">
              R
            </span>
            <span className="font-mono text-[13px]">Admin</span>
          </Link>
          <nav aria-label="Admin" className="flex flex-wrap items-center gap-x-5">
            <Link
              href="/admin"
              className="flex min-h-11 items-center font-mono text-[13px] hover:text-accent"
            >
              Reports
            </Link>
            <Link
              href="/admin/gallery"
              className="flex min-h-11 items-center font-mono text-[13px] hover:text-accent"
            >
              Gallery
            </Link>
            <Link
              href="/admin/messages"
              className="flex min-h-11 items-center font-mono text-[13px] hover:text-accent"
            >
              Messages
            </Link>
            <Link
              href="/"
              className="flex min-h-11 items-center font-mono text-[13px] hover:text-accent"
            >
              View site
            </Link>
          </nav>
          <div className="ml-auto flex items-center gap-2">
            <span className="hidden font-mono text-xs text-muted md:inline">
              {state.email}
            </span>
            <ThemeToggle />
            <button
              type="button"
              onClick={signOut}
              className="flex min-h-11 cursor-pointer items-center rounded-xl border border-line px-4 font-mono text-[13px] hover:border-accent hover:text-accent"
            >
              Sign out
            </button>
          </div>
        </div>
      </header>
      <main className="mx-auto w-full max-w-[1100px] flex-1 px-5 pt-10 pb-20 sm:px-8">
        {children}
      </main>
    </>
  );
}
