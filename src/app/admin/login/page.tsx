"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import {
  errorMessage,
  inputClass,
  labelClass,
  primaryButton,
} from "@/components/admin/ui";
import { createClient } from "@/lib/supabase";

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  // Already signed in? Go straight to the panel.
  useEffect(() => {
    createClient()
      .auth.getSession()
      .then(({ data }) => {
        if (data.session) router.replace("/admin");
      });
  }, [router]);

  async function signIn(event: React.FormEvent) {
    event.preventDefault();
    setBusy(true);
    setError(null);
    const { error } = await createClient().auth.signInWithPassword({
      email: email.trim(),
      password,
    });
    if (error) {
      setError(
        error.message === "Invalid login credentials"
          ? "That email and password don't match an account."
          : errorMessage(error),
      );
      setBusy(false);
      return;
    }
    router.replace("/admin");
  }

  return (
    <div className="flex flex-1 items-center justify-center px-5 py-16">
      <form
        onSubmit={signIn}
        className="flex w-full max-w-[420px] flex-col gap-6 rounded-3xl border border-line bg-card p-8"
      >
        <div className="flex flex-col gap-2">
          <p className="font-mono text-xs text-accent">{"// ADMIN"}</p>
          <h1 className="display text-5xl">Sign in</h1>
        </div>

        <label className="flex flex-col gap-2">
          <span className={labelClass}>Email</span>
          <input
            type="email"
            autoComplete="username"
            required
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            className={inputClass}
          />
        </label>

        <label className="flex flex-col gap-2">
          <span className={labelClass}>Password</span>
          <input
            type="password"
            autoComplete="current-password"
            required
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            className={inputClass}
          />
        </label>

        {error && (
          <p role="alert" className="text-sm text-ink">
            {error}
          </p>
        )}

        <button type="submit" disabled={busy} className={primaryButton}>
          {busy ? "Signing in" : "Sign in"}
        </button>

        <Link
          href="/"
          className="self-center font-mono text-xs text-muted underline underline-offset-4"
        >
          Back to the site
        </Link>
      </form>
    </div>
  );
}
