"use server";

import { updateTag } from "next/cache";

/** Called by the admin panel after saving so visitors see the change at once. */
export async function refreshContent() {
  updateTag("reports");
}
