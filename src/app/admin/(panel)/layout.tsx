import { AdminGuard } from "@/components/admin/admin-guard";

// The panel shows nothing until the sign-in check finishes, so there is no
// page content to prepare ahead of time. This tells Next.js not to flag that.
export const instant = false;

export default function PanelLayout({ children }: { children: React.ReactNode }) {
  return <AdminGuard>{children}</AdminGuard>;
}
