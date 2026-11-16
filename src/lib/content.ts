// Temporary site content, taken from the previous portfolio site.
// It moves to the Supabase database once the admin panel exists.

export type Course = "Mobile App" | "Web Programming";

export type Report = {
  course: Course;
  /** Short label shown beside the title, e.g. "Practicum 07". */
  label: string;
  title: string;
  /** Points at the previous site until report pages are migrated. */
  href: string;
};

const oldSite = "https://zann.ifportofolio.com";

/** Newest first within each course. */
export const reports: Report[] = [
  {
    course: "Mobile App",
    label: "Practicum 07",
    title: "List, Grid, Images, and Assets in ResepKu",
    href: `${oldSite}/laprak_MobApp-7.html`,
  },
  {
    course: "Mobile App",
    label: "Practicum 06",
    title: "State Management in ResepKu",
    href: `${oldSite}/laprak_MobApp-6.html`,
  },
  {
    course: "Mobile App",
    label: "Practicum 05",
    title: "Navigation Architecture and Expense Tracker with Local Storage",
    href: `${oldSite}/laprak_MobApp-5.html`,
  },
  {
    course: "Mobile App",
    label: "Practicum 04",
    title: "Navigation and Passing Data",
    href: `${oldSite}/laprak_MobApp-4.html`,
  },
  {
    course: "Mobile App",
    label: "Practicum 03",
    title: "Input Widgets and Forms: Capturing Data, Dropdowns, and Validation",
    href: `${oldSite}/laprak_MobApp-3.html`,
  },
  {
    course: "Mobile App",
    label: "Practicum 02",
    title: "Widgets, Layouting, and Styling",
    href: `${oldSite}/laprak_MobApp-2.html`,
  },
  {
    course: "Mobile App",
    label: "Practicum 01",
    title: "Input Widgets and Basic Form in Flutter",
    href: `${oldSite}/laprak_MobApp-1.html`,
  },
  {
    course: "Web Programming",
    label: "Laravel",
    title: "Laravel SISFO: CRUD and Role-Based Access Control",
    href: `${oldSite}/laporan9.html`,
  },
  {
    course: "Web Programming",
    label: "Laravel",
    title: "Laravel CRUD: Student, Major, and Subject Relationships",
    href: `${oldSite}/laporan8-2.html`,
  },
  {
    course: "Web Programming",
    label: "Laravel",
    title: "Laravel MVC: Migration, Seeding, Routing, Model, Controller, and View",
    href: `${oldSite}/laporan8.html`,
  },
  {
    course: "Web Programming",
    label: "Web basics",
    title: "UI Implementation and Simple CRUD",
    href: `${oldSite}/laporan.html`,
  },
];

export const courses: Course[] = ["Mobile App", "Web Programming"];

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
    period: "2025 to present",
  },
  {
    place: "FESTIKA 2025",
    detail: "Equipment Staff",
    period: "May 2025",
  },
];
