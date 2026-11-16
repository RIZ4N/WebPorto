// Shared class names for the admin panel's form controls.
export const inputClass =
  "min-h-12 w-full rounded-xl border border-line bg-card px-4 text-[15px] text-ink placeholder:text-muted focus:border-accent focus:outline-none";

export const labelClass = "font-mono text-xs text-muted uppercase";

export const primaryButton =
  "flex min-h-12 cursor-pointer items-center justify-center gap-2 rounded-xl bg-accent px-5 font-mono text-sm font-medium text-on-accent transition-transform hover:-translate-y-0.5 disabled:cursor-not-allowed disabled:opacity-60 disabled:hover:translate-y-0";

export const quietButton =
  "flex min-h-12 cursor-pointer items-center justify-center gap-2 rounded-xl border border-line bg-card px-5 font-mono text-sm font-medium text-ink transition-colors hover:border-accent hover:text-accent disabled:cursor-not-allowed disabled:opacity-60";

/** Supabase errors are plain objects, not Error instances. */
export function errorMessage(error: unknown) {
  if (error && typeof error === "object" && "message" in error) {
    return String((error as { message: unknown }).message);
  }
  return "Something went wrong. Please try again.";
}
