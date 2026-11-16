"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { refreshContent } from "@/app/actions";
import { errorMessage, inputClass, primaryButton, quietButton } from "@/components/admin/ui";
import { createClient } from "@/lib/supabase";
import { uploadPicture } from "@/lib/upload";

type Photo = { id: string; image_url: string; caption: string; position: number };

async function fetchPhotos(): Promise<{ photos: Photo[] | null; error: string | null }> {
  const { data, error } = await createClient()
    .from("gallery_photos")
    .select("id, image_url, caption, position")
    .order("position")
    .order("created_at");
  if (error) return { photos: null, error: errorMessage(error) };
  return { photos: data as Photo[], error: null };
}

export default function AdminGalleryPage() {
  const [photos, setPhotos] = useState<Photo[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [confirming, setConfirming] = useState<string | null>(null);
  const fileInput = useRef<HTMLInputElement>(null);

  const apply = useCallback((result: Awaited<ReturnType<typeof fetchPhotos>>) => {
    setError(result.error);
    if (result.photos) setPhotos(result.photos);
  }, []);

  useEffect(() => {
    let cancelled = false;
    fetchPhotos().then((result) => {
      if (!cancelled) apply(result);
    });
    return () => {
      cancelled = true;
    };
  }, [apply]);

  async function reload() {
    await refreshContent();
    apply(await fetchPhotos());
  }

  async function addPhotos(files: FileList | null) {
    if (!files || files.length === 0) return;
    setBusy(true);
    setError(null);
    try {
      let position = Math.max(-1, ...(photos ?? []).map((photo) => photo.position));
      for (const file of Array.from(files)) {
        if (!file.type.startsWith("image/")) throw new Error(`${file.name} isn't a picture.`);
        if (file.size > 5 * 1024 * 1024) throw new Error(`${file.name} is larger than 5 MB.`);
        const image_url = await uploadPicture(file, "gallery");
        position += 1;
        const { error } = await createClient()
          .from("gallery_photos")
          .insert({ image_url, caption: "", position });
        if (error) throw error;
      }
    } catch (error) {
      setError(errorMessage(error));
    } finally {
      if (fileInput.current) fileInput.current.value = "";
      await reload();
      setBusy(false);
    }
  }

  async function saveCaption(photo: Photo, caption: string) {
    if (caption === photo.caption) return;
    const { error } = await createClient()
      .from("gallery_photos")
      .update({ caption })
      .eq("id", photo.id);
    if (error) setError(errorMessage(error));
    await reload();
  }

  async function move(index: number, offset: -1 | 1) {
    if (!photos) return;
    const target = index + offset;
    if (target < 0 || target >= photos.length) return;
    const next = [...photos];
    [next[index], next[target]] = [next[target], next[index]];
    setPhotos(next);
    const supabase = createClient();
    // Renumber everything so positions stay unique and in the shown order.
    const results = await Promise.all(
      next.map((photo, position) =>
        supabase.from("gallery_photos").update({ position }).eq("id", photo.id),
      ),
    );
    const failed = results.find((result) => result.error);
    if (failed?.error) setError(errorMessage(failed.error));
    await reload();
  }

  async function remove(id: string) {
    const { error } = await createClient().from("gallery_photos").delete().eq("id", id);
    setConfirming(null);
    if (error) setError(errorMessage(error));
    await reload();
  }

  return (
    <div className="flex flex-col gap-8">
      <div className="flex flex-wrap items-end justify-between gap-4 border-b border-line pb-6">
        <h1 className="display text-6xl">Gallery</h1>
        <button
          type="button"
          disabled={busy}
          onClick={() => fileInput.current?.click()}
          className={primaryButton}
        >
          {busy ? "Uploading" : "Add photos"}
        </button>
        <input
          ref={fileInput}
          type="file"
          accept="image/*"
          multiple
          className="hidden"
          aria-label="Choose photos"
          onChange={(event) => addPhotos(event.target.files)}
        />
      </div>

      {error && (
        <p role="alert" className="rounded-2xl border border-ink bg-card p-4 text-sm">
          {error}
        </p>
      )}

      {photos === null && !error && (
        <p className="font-mono text-sm text-muted">Loading photos</p>
      )}

      {photos?.length === 0 && (
        <p className="rounded-2xl border border-line bg-card p-6">
          No photos yet. The gallery section stays hidden on the site until you add one.
        </p>
      )}

      <ul className="flex flex-col gap-3">
        {photos?.map((photo, index) => (
          <li
            key={photo.id}
            className="flex flex-wrap items-center gap-4 rounded-2xl border border-line bg-card p-4"
          >
            {/* A plain img: the admin list doesn't need resized copies. */}
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src={photo.image_url}
              alt={photo.caption || "Gallery photo"}
              className="h-24 w-32 rounded-xl border border-line object-cover"
            />
            <label className="flex min-w-0 flex-1 basis-60 flex-col gap-2">
              <span className="font-mono text-xs text-muted uppercase">Caption</span>
              <input
                defaultValue={photo.caption}
                placeholder="What is this photo?"
                onBlur={(event) => saveCaption(photo, event.target.value.trim())}
                className={inputClass}
              />
            </label>
            <div className="flex flex-wrap items-center gap-2">
              <button
                type="button"
                aria-label={`Move photo ${index + 1} earlier`}
                disabled={index === 0}
                onClick={() => move(index, -1)}
                className={`${quietButton} px-4`}
              >
                Up
              </button>
              <button
                type="button"
                aria-label={`Move photo ${index + 1} later`}
                disabled={index === photos.length - 1}
                onClick={() => move(index, 1)}
                className={`${quietButton} px-4`}
              >
                Down
              </button>
              {confirming === photo.id ? (
                <>
                  <button
                    type="button"
                    onClick={() => remove(photo.id)}
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
                  aria-label={`Delete photo ${index + 1}`}
                  onClick={() => setConfirming(photo.id)}
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
