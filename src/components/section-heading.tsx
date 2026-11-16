export function SectionHeading({
  eyebrow,
  title,
  as: Tag = "h2",
}: {
  eyebrow: string;
  title: string;
  as?: "h1" | "h2";
}) {
  return (
    <div className="flex flex-col gap-3">
      <p className="text-[13px] font-semibold tracking-[0.12em] text-accent uppercase">
        {eyebrow}
      </p>
      <Tag className="font-serif text-4xl leading-[1.1] tracking-tight md:text-[2.75rem]">
        {title}
      </Tag>
    </div>
  );
}
