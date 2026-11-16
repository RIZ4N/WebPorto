"use client";

import Image from "@tiptap/extension-image";
import { TableKit } from "@tiptap/extension-table";
import TextAlign from "@tiptap/extension-text-align";
import { Placeholder } from "@tiptap/extensions/placeholder";
import { EditorContent, useEditor } from "@tiptap/react";
import StarterKit from "@tiptap/starter-kit";
import { useRef, useState } from "react";

type Props = {
  /** Starting HTML. Later changes come from typing, not from this prop. */
  initialContent: string;
  onChange: (html: string) => void;
  /** Uploads a picture and resolves with its public address. */
  onUpload: (file: File) => Promise<string>;
};

function ToolButton({
  label,
  active = false,
  disabled = false,
  onClick,
  children,
}: {
  label: string;
  active?: boolean;
  disabled?: boolean;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      type="button"
      title={label}
      aria-label={label}
      aria-pressed={active}
      disabled={disabled}
      // Keep the text selection while clicking a tool.
      onMouseDown={(event) => event.preventDefault()}
      onClick={onClick}
      className={`flex h-10 min-w-10 cursor-pointer items-center justify-center rounded-lg px-2.5 font-mono text-[13px] transition-colors disabled:cursor-not-allowed disabled:opacity-40 ${
        active ? "bg-accent text-on-accent" : "text-ink hover:bg-accent-tint"
      }`}
    >
      {children}
    </button>
  );
}

/** Rich text box for one chapter: headings, lists, code, links, pictures and tables. */
export function RichEditor({ initialContent, onChange, onUpload }: Props) {
  const fileInput = useRef<HTMLInputElement>(null);
  const [linkValue, setLinkValue] = useState<string | null>(null);
  const [uploading, setUploading] = useState(false);
  const [notice, setNotice] = useState<string | null>(null);

  const editor = useEditor({
    extensions: [
      StarterKit.configure({
        heading: { levels: [3, 4] },
        link: { openOnClick: false, autolink: true },
      }),
      Image,
      TableKit.configure({ table: { resizable: false } }),
      TextAlign.configure({ types: ["paragraph", "heading"], alignments: ["left", "center"] }),
      Placeholder.configure({ placeholder: "Write this chapter here" }),
    ],
    content: initialContent,
    // Next.js renders on the server first; the editor only exists in the browser.
    immediatelyRender: false,
    shouldRerenderOnTransaction: true,
    editorProps: { attributes: { class: "tiptap report-body" } },
    onUpdate: ({ editor }) => onChange(editor.isEmpty ? "" : editor.getHTML()),
  });

  if (!editor) {
    return <div className="min-h-[280px] rounded-2xl border border-line bg-card" />;
  }

  async function addPicture(file: File | undefined) {
    if (!file || !editor) return;
    if (!file.type.startsWith("image/")) {
      setNotice("That file isn't a picture.");
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      setNotice("Pictures can be up to 5 MB.");
      return;
    }
    setUploading(true);
    setNotice(null);
    try {
      const src = await onUpload(file);
      editor
        .chain()
        .focus()
        .setImage({ src, alt: file.name.replace(/\.[^.]+$/, "") })
        .run();
    } catch {
      setNotice("The picture couldn't be uploaded. Check your connection and try again.");
    } finally {
      setUploading(false);
      if (fileInput.current) fileInput.current.value = "";
    }
  }

  function applyLink() {
    if (!editor || linkValue === null) return;
    const href = linkValue.trim();
    const chain = editor.chain().focus().extendMarkRange("link");
    if (href) chain.setLink({ href }).run();
    else chain.unsetLink().run();
    setLinkValue(null);
  }

  return (
    <div className="overflow-hidden rounded-2xl border border-line bg-card focus-within:border-accent">
      <div
        role="toolbar"
        aria-label="Formatting"
        className="flex flex-wrap items-center gap-1 border-b border-line p-2"
      >
        <ToolButton
          label="Subheading"
          active={editor.isActive("heading", { level: 3 })}
          onClick={() => editor.chain().focus().toggleHeading({ level: 3 }).run()}
        >
          H1
        </ToolButton>
        <ToolButton
          label="Smaller subheading"
          active={editor.isActive("heading", { level: 4 })}
          onClick={() => editor.chain().focus().toggleHeading({ level: 4 }).run()}
        >
          H2
        </ToolButton>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-line" />
        <ToolButton
          label="Bold"
          active={editor.isActive("bold")}
          onClick={() => editor.chain().focus().toggleBold().run()}
        >
          <strong>B</strong>
        </ToolButton>
        <ToolButton
          label="Italic"
          active={editor.isActive("italic")}
          onClick={() => editor.chain().focus().toggleItalic().run()}
        >
          <em>I</em>
        </ToolButton>
        <ToolButton
          label="Underline"
          active={editor.isActive("underline")}
          onClick={() => editor.chain().focus().toggleUnderline().run()}
        >
          <span className="underline">U</span>
        </ToolButton>
        <ToolButton
          label="Inline code"
          active={editor.isActive("code")}
          onClick={() => editor.chain().focus().toggleCode().run()}
        >
          {"<>"}
        </ToolButton>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-line" />
        <ToolButton
          label="Bulleted list"
          active={editor.isActive("bulletList")}
          onClick={() => editor.chain().focus().toggleBulletList().run()}
        >
          • List
        </ToolButton>
        <ToolButton
          label="Numbered list"
          active={editor.isActive("orderedList")}
          onClick={() => editor.chain().focus().toggleOrderedList().run()}
        >
          1. List
        </ToolButton>
        <ToolButton
          label="Quote"
          active={editor.isActive("blockquote")}
          onClick={() => editor.chain().focus().toggleBlockquote().run()}
        >
          Quote
        </ToolButton>
        <ToolButton
          label="Code block"
          active={editor.isActive("codeBlock")}
          onClick={() => editor.chain().focus().toggleCodeBlock().run()}
        >
          Code
        </ToolButton>
        <ToolButton
          label="Centre text (for captions)"
          active={editor.isActive({ textAlign: "center" })}
          onClick={() =>
            editor.isActive({ textAlign: "center" })
              ? editor.chain().focus().unsetTextAlign().run()
              : editor.chain().focus().setTextAlign("center").run()
          }
        >
          Centre
        </ToolButton>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-line" />
        <ToolButton
          label="Link"
          active={editor.isActive("link") || linkValue !== null}
          onClick={() =>
            setLinkValue(
              linkValue === null ? (editor.getAttributes("link").href ?? "") : null,
            )
          }
        >
          Link
        </ToolButton>
        <ToolButton
          label="Add picture"
          disabled={uploading}
          onClick={() => fileInput.current?.click()}
        >
          {uploading ? "Uploading" : "Picture"}
        </ToolButton>
        <ToolButton
          label="Insert table"
          disabled={editor.isActive("table")}
          onClick={() =>
            editor.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run()
          }
        >
          Table
        </ToolButton>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-line" />
        <ToolButton
          label="Undo"
          disabled={!editor.can().undo()}
          onClick={() => editor.chain().focus().undo().run()}
        >
          Undo
        </ToolButton>
        <ToolButton
          label="Redo"
          disabled={!editor.can().redo()}
          onClick={() => editor.chain().focus().redo().run()}
        >
          Redo
        </ToolButton>
        <input
          ref={fileInput}
          type="file"
          accept="image/*"
          className="hidden"
          aria-label="Choose a picture"
          onChange={(event) => addPicture(event.target.files?.[0])}
        />
      </div>

      {editor.isActive("table") && (
        <div
          role="toolbar"
          aria-label="Table"
          className="flex flex-wrap items-center gap-1 border-b border-line p-2"
        >
          <span className="px-2 font-mono text-xs text-muted">Table</span>
          <ToolButton label="Add row below" onClick={() => editor.chain().focus().addRowAfter().run()}>
            + Row
          </ToolButton>
          <ToolButton label="Add column to the right" onClick={() => editor.chain().focus().addColumnAfter().run()}>
            + Column
          </ToolButton>
          <ToolButton label="Remove this row" onClick={() => editor.chain().focus().deleteRow().run()}>
            − Row
          </ToolButton>
          <ToolButton label="Remove this column" onClick={() => editor.chain().focus().deleteColumn().run()}>
            − Column
          </ToolButton>
          <ToolButton label="Remove the table" onClick={() => editor.chain().focus().deleteTable().run()}>
            Remove table
          </ToolButton>
        </div>
      )}

      {linkValue !== null && (
        <div className="flex flex-wrap items-center gap-2 border-b border-line p-2">
          <input
            type="url"
            autoFocus
            aria-label="Link address"
            placeholder="https://"
            value={linkValue}
            onChange={(event) => setLinkValue(event.target.value)}
            onKeyDown={(event) => {
              if (event.key === "Enter") {
                event.preventDefault();
                applyLink();
              }
              if (event.key === "Escape") setLinkValue(null);
            }}
            className="min-h-10 min-w-0 flex-1 rounded-lg border border-line bg-ground px-3 text-sm focus:border-accent focus:outline-none"
          />
          <button
            type="button"
            onClick={applyLink}
            className="flex h-10 cursor-pointer items-center rounded-lg bg-accent px-3 font-mono text-[13px] text-on-accent"
          >
            {linkValue.trim() ? "Set link" : "Remove link"}
          </button>
        </div>
      )}

      {notice && (
        <p role="alert" className="border-b border-line px-4 py-2 text-sm">
          {notice}
        </p>
      )}

      <EditorContent editor={editor} />
    </div>
  );
}
