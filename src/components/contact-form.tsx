"use client";

import { useState } from "react";
import { createClient } from "@/lib/supabase";

type Status =
  | { kind: "idle" }
  | { kind: "sending" }
  | { kind: "sent" }
  | { kind: "error"; text: string };

const fieldClass =
  "min-h-12 w-full rounded-xl border border-line bg-ground px-4 text-[15px] text-ink placeholder:text-muted focus:border-accent focus:outline-none";

/** Short message form; messages land in the admin panel's inbox. */
export function ContactForm() {
  const [status, setStatus] = useState<Status>({ kind: "idle" });

  async function send(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const form = event.currentTarget;
    const data = new FormData(form);
    const name = String(data.get("name") ?? "").trim();
    const email = String(data.get("email") ?? "").trim();
    const message = String(data.get("message") ?? "").trim();

    // Hidden field that people never see; bots fill it in, so quietly drop those.
    if (data.get("website")) {
      setStatus({ kind: "sent" });
      return;
    }
    if (!name || !email || !message) {
      setStatus({ kind: "error", text: "Fill in your name, email and message first." });
      return;
    }

    setStatus({ kind: "sending" });
    try {
      const { error } = await createClient()
        .from("messages")
        .insert({ name, email, message });
      if (error) {
        const tooMany = error.message.startsWith("Too many messages");
        const badEmail = error.message.includes("messages_email_check");
        setStatus({
          kind: "error",
          text: tooMany
            ? "The inbox is busy right now. Try again in a little while, or email me instead."
            : badEmail
              ? "That email address doesn't look right. Check it and send again."
              : "Your message couldn't be sent. Try again, or email me instead.",
        });
        return;
      }
      form.reset();
      setStatus({ kind: "sent" });
    } catch {
      setStatus({
        kind: "error",
        text: "Your message couldn't be sent. Check your connection and try again.",
      });
    }
  }

  if (status.kind === "sent") {
    return (
      <div
        role="status"
        className="flex flex-col items-start gap-4 rounded-3xl bg-card p-6 text-ink sm:p-8"
      >
        <p className="display text-4xl">Message sent</p>
        <p className="text-[15px] text-muted">
          Thanks for writing. I&apos;ll reply to the email you gave.
        </p>
        <button
          type="button"
          onClick={() => setStatus({ kind: "idle" })}
          className="flex min-h-11 cursor-pointer items-center rounded-xl border border-line px-4 font-mono text-[13px] hover:border-accent hover:text-accent"
        >
          Write another
        </button>
      </div>
    );
  }

  return (
    <form
      onSubmit={send}
      className="flex flex-col gap-4 rounded-3xl bg-card p-6 text-ink sm:p-8"
    >
      <p className="font-mono text-xs text-accent">{"// WRITE A MESSAGE"}</p>
      <div className="grid grid-cols-[repeat(auto-fit,minmax(min(200px,100%),1fr))] gap-4">
        <label className="flex flex-col gap-2">
          <span className="font-mono text-xs text-muted uppercase">Name</span>
          <input name="name" required maxLength={120} autoComplete="name" className={fieldClass} />
        </label>
        <label className="flex flex-col gap-2">
          <span className="font-mono text-xs text-muted uppercase">Email</span>
          <input
            name="email"
            type="email"
            required
            maxLength={200}
            autoComplete="email"
            className={fieldClass}
          />
        </label>
      </div>
      <label className="flex flex-col gap-2">
        <span className="font-mono text-xs text-muted uppercase">Message</span>
        <textarea
          name="message"
          required
          rows={4}
          maxLength={4000}
          className={`${fieldClass} py-3 leading-relaxed`}
        />
      </label>
      <input
        name="website"
        type="text"
        tabIndex={-1}
        autoComplete="off"
        aria-hidden="true"
        className="hidden"
      />
      {status.kind === "error" && (
        <p role="alert" className="text-sm">
          {status.text}
        </p>
      )}
      <button
        type="submit"
        disabled={status.kind === "sending"}
        className="flex min-h-14 cursor-pointer items-center justify-center rounded-2xl bg-accent px-6 font-mono text-[15px] font-medium text-on-accent transition-transform hover:-translate-y-0.5 disabled:cursor-not-allowed disabled:opacity-60"
      >
        {status.kind === "sending" ? "Sending" : "Send message"}
      </button>
    </form>
  );
}
