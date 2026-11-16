// Site content that is not in the database yet (projects, about), plus the
// report list used as a fallback when Supabase can't be reached.

import type { GalleryPhoto, ReportSummary } from "./data";

const oldSite = "https://zann.ifportofolio.com";

function legacy(
  course: string,
  courseOrder: number,
  number: number,
  label: string,
  title: string,
  page: string,
): ReportSummary {
  return {
    id: page,
    slug: page.replace(".html", ""),
    title,
    label,
    summary: "",
    course,
    courseOrder,
    number,
    coverUrl: null,
    href: `${oldSite}/${page}`,
    external: true,
  };
}

/** Newest first. */
export const fallbackReports: ReportSummary[] = [
  {
    ...legacy("Mobile App", 1, 7, "Practicum 07", "List, Grid, Images, and Assets in ResepKu", "laprak_MobApp-7.html"),
    summary:
      "ResepKu, my recipe app in Flutter, gets list and grid views, recipe photos, and bundled assets.",
    coverUrl: "/images/reports/resepku-grid.jpg",
  },
  legacy("Mobile App", 1, 6, "Practicum 06", "State Management in ResepKu", "laprak_MobApp-6.html"),
  legacy("Mobile App", 1, 5, "Practicum 05", "Navigation Architecture and Expense Tracker with Local Storage", "laprak_MobApp-5.html"),
  legacy("Web Programming", 2, 4, "Laravel", "Laravel SISFO: CRUD and Role-Based Access Control", "laporan9.html"),
  legacy("Web Programming", 2, 3, "Laravel", "Laravel CRUD: Student, Major, and Subject Relationships", "laporan8-2.html"),
  legacy("Mobile App", 1, 4, "Practicum 04", "Navigation and Passing Data", "laprak_MobApp-4.html"),
  legacy("Mobile App", 1, 3, "Practicum 03", "Input Widgets and Forms: Capturing Data, Dropdowns, and Validation", "laprak_MobApp-3.html"),
  legacy("Mobile App", 1, 2, "Practicum 02", "Widgets, Layouting, and Styling", "laprak_MobApp-2.html"),
  legacy("Mobile App", 1, 1, "Practicum 01", "Input Widgets and Basic Form in Flutter", "laprak_MobApp-1.html"),
  legacy("Web Programming", 2, 2, "Laravel", "Laravel MVC: Migration, Seeding, Routing, Model, Controller, and View", "laporan8.html"),
  legacy("Web Programming", 2, 1, "Web basics", "UI Implementation and Simple CRUD", "laporan.html"),
];

export type Project = {
  title: string;
  description: string;
  tech: string[];
  image: string;
};

export const projects: Project[] = [
  {
    title: "Web Porto",
    description:
      "My first personal portfolio site: responsive, easy to navigate, and built to show my web and UI work.",
    tech: ["HTML", "CSS", "Bootstrap 5"],
    image: "/images/projects/web-porto.jpg",
  },
  {
    title: "Learning Platform",
    description:
      "Design concept for an online course platform, focused on an immersive learning experience.",
    tech: ["UI Design", "Figma", "Adobe XD"],
    image: "/images/projects/learning-platform.jpg",
  },
  {
    title: "Remastering Ubuntu",
    description:
      "A personalised Ubuntu build with its own wallpaper and boot logo.",
    tech: ["Ubuntu", "VirtualBox"],
    image: "/images/projects/remastering-ubuntu.jpg",
  },
];

export const stack = ["Flutter", "Dart", "Laravel", "HTML and CSS", "Bootstrap", "Figma"];

export const education = [
  {
    place: "Universitas Andalas",
    detail: "S1 Informatika",
    period: "2024 to present",
  },
  {
    place: "MAN 1 Medan",
    detail: "Science track",
    period: "2021 to 2024",
  },
];

export const experience = [
  {
    place: "Himpunan Mahasiswa Informatika",
    detail: "Staff, External Division",
    period: "2025 to 2026",
  },
  {
    place: "FESTIKA 2025",
    detail: "Equipment Staff",
    period: "May 2025",
  },
];

export const contact = {
  email: "rizanoesvan@gmail.com",
  // TODO(Rizan): replace with your LinkedIn profile address.
  linkedin: "https://www.linkedin.com/in/rizan-oesvan-9491b931b/",
  github: "https://github.com/RIZ4N",
  instagram: "https://www.instagram.com/rizanoesvan/",
};

/** Shown when the gallery can't be read from the database. */
export const fallbackGallery: GalleryPhoto[] = [
  { id: "photo-1", imageUrl: "/images/gallery/photo-1.webp", caption: "Terraced rice fields" },
  { id: "photo-2", imageUrl: "/images/gallery/photo-2.webp", caption: "Castle on a forested hill" },
  { id: "photo-3", imageUrl: "/images/gallery/photo-3.webp", caption: "Laptop with code on a desk" },
];
