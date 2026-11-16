"use client";

import { useCallback, useEffect, useState } from "react";
import { errorMessage, quietButton } from "@/components/admin/ui";
import { createClient } from "@/lib/supabase";

type Message = {
  id: string;
  name: string;
  email: string;
  message: string;
  created_at: string;
};

async function fetchMessages(): Promise<{ messages: Message[] | null; error: string | null }> {
  const { data, error } = await createClient()
    .from("messages")
    .select("id, name, email, message, created_at")
    .order("created_at", { ascending: false });
  if (error) return { messages: null, error: errorMessage(error) };
  return { messages: data as Message[], error: null };
}

export default function AdminMessagesPage() {
  const [messages, setMessages] = useState<Message[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [confirming, setConfirming] = useState<string | null>(null);

  const apply = useCallback((result: Awaited<ReturnType<typeof fetchMessages>>) => {
    setError(result.error);
    if (result.messages) setMessages(result.messages);
  }, []);

  useEffect(() => {
    let cancelled = false;
    fetchMessages().then((result) => {
      if (!cancelled) apply(result);
    });
    return () => {
      cancelled = true;
    };
  }, [apply]);

  async function remove(id: string) {
    const { error } = await createClient().from("messages").delete().eq("id", id);
    setConfirming(null);
    if (error) setError(errorMessage(error));
    apply(await fetchMessages());
  }

  return (
    <div className="flex flex-col gap-8">
      <div className="flex flex-wrap items-end justify-between gap-4 border-b border-line pb-6">
        <h1 className="display text-6xl">Messages</h1>
        {messages && (
          <span className="font-mono text-xs text-muted">
            {messages.length} {messages.length === 1 ? "message" : "messages"}
          </span>
        )}
      </div>

      {error && (
        <p role="alert" className="rounded-2xl border border-ink bg-card p-4 text-sm">
          {error}
        </p>
      )}

      {messages === null && !error && (
        <p className="font-mono text-sm text-muted">Loading messages</p>
      )}

      {messages?.length === 0 && (
        <p className="rounded-2xl border border-line bg-card p-6">
          No messages yet. Anything sent from the contact form shows up here.
        </p>
      )}

      <ul className="flex flex-col gap-3">
        {messages?.map((item) => (
          <li
            key={item.id}
            className="flex flex-col gap-4 rounded-2xl border border-line bg-card p-5"
          >
            <div className="flex flex-wrap items-baseline justify-between gap-x-6 gap-y-1">
              <div className="flex flex-wrap items-baseline gap-x-3">
                <span className="text-lg font-medium">{item.name}</span>
                <a
                  href={`mailto:${item.email}`}
                  className="font-mono text-[13px] text-accent underline underline-offset-4"
                >
                  {item.email}
                </a>
              </div>
              <time dateTime={item.created_at} className="font-mono text-xs text-muted">
                {new Date(item.created_at).toLocaleString()}
              </time>
            </div>
            <p className="leading-relaxed whitespace-pre-wrap">{item.message}</p>
            <div className="flex flex-wrap gap-2">
              <a href={`mailto:${item.email}`} className={quietButton}>
                Reply by email
              </a>
              {confirming === item.id ? (
                <>
                  <button
                    type="button"
                    onClick={() => remove(item.id)}
                    className="flex min-h-12 cursor-pointer items-center rounded-xl bg-ink px-4 font-mono text-sm text-ground"
                  >
                    Yes, delete
                  </button>
                  <button
                    type="button"
                    onClick={() => setConfirming(null)}
                    className={`${quietButton} px-4`}
                  >
                    Keep
                  </button>
                </>
              ) : (
                <button
                  type="button"
                  onClick={() => setConfirming(item.id)}
                  className={`${quietButton} px-4`}
                >
                  Delete
                </button>
              )}
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}
