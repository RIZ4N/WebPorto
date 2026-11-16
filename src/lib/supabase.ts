import { createBrowserClient } from "@supabase/ssr";

// Both values are safe to expose in the browser; access is limited by
// row level security rules in the database, not by hiding this key.
export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!,
  );
}
