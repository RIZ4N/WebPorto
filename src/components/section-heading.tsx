export function SectionHeading({
  number,
  title,
  description,
  as: Tag = "h2",
  tone = "ground",
}: {
  number: string;
  title: string;
  description?: string;
  as?: "h1" | "h2";
  /** "panel" is for headings that sit on the always-dark blocks. */
  tone?: "ground" | "panel";
}) {
  const onPanel = tone === "panel";
  return (
    <div
      className={`flex flex-wrap items-end justify-between gap-x-12 gap-y-4 border-b pb-6 ${
        onPanel ? "border-panel-line" : "border-line"
      }`}
    >
      <div className="flex items-center gap-4">
        <span
          aria-hidden="true"
          className={`flex size-10 shrink-0 -rotate-6 items-center justify-center rounded-xl font-mono text-[13px] font-medium ${
            onPanel
              ? "bg-panel-accent text-panel"
              : "bg-accent text-on-accent"
          }`}
        >
          {number}
        </span>
        <Tag className="display text-[clamp(2.5rem,6vw,4.25rem)]">{title}</Tag>
      </div>
      {description && (
        <p
          className={`max-w-sm font-mono text-[13px] leading-relaxed ${
            onPanel ? "text-panel-muted" : "text-muted"
          }`}
        >
          {description}
        </p>
      )}
    </div>
  );
}
