import { Suspense } from "react";
import { ReportEditor } from "@/components/admin/report-editor";

export default function EditorPage() {
  return (
    <Suspense
      fallback={<p className="font-mono text-sm text-muted">Loading the editor</p>}
    >
      <ReportEditor />
    </Suspense>
  );
}
