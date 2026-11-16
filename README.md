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

## Set up Supabase (once)

1. In the Supabase dashboard open **SQL Editor**, paste all of
   `supabase/schema.sql`, and press **Run**. This creates the tables, the
   access rules, the image storage, and the starting list of reports.
2. Open **Authentication > Users > Add user**, enter your email and a
   password, and tick "Auto Confirm User".
3. Back in **SQL Editor**, make that account an admin (use your own email):

   ```sql
   insert into public.admins (user_id)
   select id from auth.users where email = 'you@example.com';
   ```

4. Sign in at http://localhost:3000/admin.
5. Optional, once: paste `supabase/migrate-old-reports.sql` into **SQL Editor**
   and run it to fill the 11 reports from the old site with their chapters.
   Their pictures are already in `public/images/legacy`. Don't run it again
   after editing those reports in the admin panel; it would replace your edits.

Only accounts listed in `admins` can change anything; visitors can only read
published reports.

## Structure

- `src/app/(site)` – public pages (`/`, `/reports`, `/reports/[slug]`)
- `src/app/admin` – admin panel (`/admin/login`, `/admin`, `/admin/editor`)
- `src/components` – shared pieces; `components/admin` holds the editor
- `src/lib/data.ts` – reads published reports from Supabase
- `src/lib/content.ts` – projects and about text, plus a fallback report list
- `src/app/globals.css` – colour tokens for the light and dark themes
- `supabase/schema.sql` – database setup
