import type { Metadata } from "next";
import "@fontsource-variable/archivo/wdth.css";
import "@fontsource-variable/inter";
import "@fontsource-variable/jetbrains-mono";
import "./globals.css";

export const metadata: Metadata = {
  title: {
    default: "Rizan Oesvan Idrati",
    template: "%s · Rizan Oesvan Idrati",
  },
  description:
    "Lab reports and projects by Rizan Oesvan Idrati, Informatics student at Universitas Andalas.",
};

// Runs before first paint: applies the saved (or system) theme so it never
// flashes, and marks that scripts are on so scroll reveals can start hidden.
const bootScript = `(function(){try{var d=document.documentElement;d.classList.add("js");var t=localStorage.getItem("theme");if(t!=="light"&&t!=="dark"){t=window.matchMedia("(prefers-color-scheme: dark)").matches?"dark":"light"}d.setAttribute("data-theme",t)}catch(e){}})()`;

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en" data-theme="light" suppressHydrationWarning>
      <head>
        <script dangerouslySetInnerHTML={{ __html: bootScript }} />
      </head>
      <body className="flex min-h-screen flex-col font-sans text-base leading-relaxed antialiased">
        {children}
      </body>
    </html>
  );
}
