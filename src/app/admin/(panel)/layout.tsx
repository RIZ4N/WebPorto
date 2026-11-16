import { AdminGuard } from "@/components/admin/admin-guard";

export default function PanelLayout({ children }: { children: React.ReactNode }) {
  return <AdminGuard>{children}</AdminGuard>;
}
