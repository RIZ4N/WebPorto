import { createClient } from "./supabase";

/** Uploads a picture to Supabase Storage and returns its public address. */
export async function uploadPicture(file: File, folder: "reports" | "gallery" = "reports") {
  const supabase = createClient();
  const extension = file.name.split(".").pop()?.toLowerCase() || "png";
  const path = `${folder}/${crypto.randomUUID()}.${extension}`;
  const { error } = await supabase.storage
    .from("media")
    .upload(path, file, { contentType: file.type, cacheControl: "31536000" });
  if (error) throw error;
  return supabase.storage.from("media").getPublicUrl(path).data.publicUrl;
}
