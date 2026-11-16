# WebPorto

Personal portfolio of Rizan Oesvan Idrati: lab reports, projects, and an about page.
Built with Next.js, Tailwind CSS, and Supabase.

## Run locally

```bash
npm install
cp .env.example .env.local   # then fill in the Supabase URL and publishable key
npm run dev
```

Open http://localhost:3000.

## Structure

- `src/app` – pages (`/` home, `/reports` report list)
- `src/components` – header, footer, theme toggle, shared pieces
- `src/lib/content.ts` – temporary content; moves to Supabase with the admin panel
- `src/app/globals.css` – colour tokens for the light and dark themes
