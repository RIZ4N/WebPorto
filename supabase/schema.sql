-- WebPorto database setup.
-- Paste this whole file into Supabase > SQL Editor and press Run.
-- It is safe to run more than once.

-- ---------------------------------------------------------------------------
-- Who may edit: one row per admin account.
-- ---------------------------------------------------------------------------
create table if not exists public.admins (
  user_id uuid primary key references auth.users (id) on delete cascade
);

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.admins where user_id = (select auth.uid())
  );
$$;

-- ---------------------------------------------------------------------------
-- Content tables.
-- ---------------------------------------------------------------------------
create table if not exists public.courses (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  slug text not null unique,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.courses (id) on delete restrict,
  title text not null,
  slug text not null unique,
  -- Short tag shown beside the title, e.g. "Practicum 07".
  label text not null default '',
  -- Used for ordering inside a course: higher numbers come first.
  number integer not null default 0,
  summary text not null default '',
  -- Optional picture shown when the report is featured on the home page.
  cover_url text,
  status text not null default 'draft' check (status in ('draft', 'published')),
  published_at timestamptz,
  -- Link to the page on the old site, used until the chapters are filled in.
  legacy_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.report_sections (
  id uuid primary key default gen_random_uuid(),
  report_id uuid not null references public.reports (id) on delete cascade,
  title text not null,
  -- Chapter body as HTML produced by the admin editor.
  content text not null default '',
  position integer not null default 0
);

create index if not exists report_sections_report_idx
  on public.report_sections (report_id, position);

-- ---------------------------------------------------------------------------
-- Access rules: everyone can read published content, only admins can write.
-- ---------------------------------------------------------------------------
alter table public.admins enable row level security;
alter table public.courses enable row level security;
alter table public.reports enable row level security;
alter table public.report_sections enable row level security;

grant usage on schema public to anon, authenticated;
grant execute on function public.is_admin() to anon, authenticated;
grant select on public.courses, public.reports, public.report_sections to anon, authenticated;
grant select on public.admins to authenticated;
grant insert, update, delete on public.courses, public.reports, public.report_sections to authenticated;

drop policy if exists "admins can see their own row" on public.admins;
create policy "admins can see their own row" on public.admins
  for select to authenticated
  using (user_id = (select auth.uid()));

drop policy if exists "courses are public" on public.courses;
create policy "courses are public" on public.courses
  for select using (true);

drop policy if exists "admins manage courses" on public.courses;
create policy "admins manage courses" on public.courses
  for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

drop policy if exists "published reports are public" on public.reports;
create policy "published reports are public" on public.reports
  for select using (status = 'published' or public.is_admin());

drop policy if exists "admins manage reports" on public.reports;
create policy "admins manage reports" on public.reports
  for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

drop policy if exists "sections of published reports are public" on public.report_sections;
create policy "sections of published reports are public" on public.report_sections
  for select using (
    public.is_admin()
    or exists (
      select 1 from public.reports r
      where r.id = report_id and r.status = 'published'
    )
  );

drop policy if exists "admins manage sections" on public.report_sections;
create policy "admins manage sections" on public.report_sections
  for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- ---------------------------------------------------------------------------
-- Image storage: anyone can view, only admins can upload or remove.
-- ---------------------------------------------------------------------------
insert into storage.buckets (id, name, public)
values ('media', 'media', true)
on conflict (id) do update set public = true;

drop policy if exists "admins upload media" on storage.objects;
create policy "admins upload media" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'media' and public.is_admin());

drop policy if exists "admins update media" on storage.objects;
create policy "admins update media" on storage.objects
  for update to authenticated
  using (bucket_id = 'media' and public.is_admin());

drop policy if exists "admins delete media" on storage.objects;
create policy "admins delete media" on storage.objects
  for delete to authenticated
  using (bucket_id = 'media' and public.is_admin());

-- ---------------------------------------------------------------------------
-- Starting content: the two courses and the reports from the old site.
-- Each report links to its old page until its chapters are written here.
-- ---------------------------------------------------------------------------
insert into public.courses (name, slug, sort_order) values
  ('Mobile App', 'mobile-app', 1),
  ('Web Programming', 'web-programming', 2)
on conflict (slug) do nothing;

insert into public.reports (course_id, title, slug, label, number, status, published_at, legacy_url)
select c.id, v.title, v.slug, v.label, v.number, 'published', now() - make_interval(mins => v.age), v.legacy_url
from (values
  ('mobile-app', 'List, Grid, Images, and Assets in ResepKu', 'mobile-app-07-list-grid-images-assets', 'Practicum 07', 7, 'https://zann.ifportofolio.com/laprak_MobApp-7.html', 0),
  ('mobile-app', 'State Management in ResepKu', 'mobile-app-06-state-management', 'Practicum 06', 6, 'https://zann.ifportofolio.com/laprak_MobApp-6.html', 1),
  ('mobile-app', 'Navigation Architecture and Expense Tracker with Local Storage', 'mobile-app-05-navigation-architecture', 'Practicum 05', 5, 'https://zann.ifportofolio.com/laprak_MobApp-5.html', 2),
  ('mobile-app', 'Navigation and Passing Data', 'mobile-app-04-navigation-passing-data', 'Practicum 04', 4, 'https://zann.ifportofolio.com/laprak_MobApp-4.html', 5),
  ('mobile-app', 'Input Widgets and Forms: Capturing Data, Dropdowns, and Validation', 'mobile-app-03-input-widgets-forms', 'Practicum 03', 3, 'https://zann.ifportofolio.com/laprak_MobApp-3.html', 6),
  ('mobile-app', 'Widgets, Layouting, and Styling', 'mobile-app-02-widgets-layouting-styling', 'Practicum 02', 2, 'https://zann.ifportofolio.com/laprak_MobApp-2.html', 7),
  ('mobile-app', 'Input Widgets and Basic Form in Flutter', 'mobile-app-01-input-widgets-basic-form', 'Practicum 01', 1, 'https://zann.ifportofolio.com/laprak_MobApp-1.html', 8),
  ('web-programming', 'Laravel SISFO: CRUD and Role-Based Access Control', 'web-laravel-sisfo', 'Laravel', 4, 'https://zann.ifportofolio.com/laporan9.html', 3),
  ('web-programming', 'Laravel CRUD: Student, Major, and Subject Relationships', 'web-laravel-crud-relationships', 'Laravel', 3, 'https://zann.ifportofolio.com/laporan8-2.html', 4),
  ('web-programming', 'Laravel MVC: Migration, Seeding, Routing, Model, Controller, and View', 'web-laravel-mvc', 'Laravel', 2, 'https://zann.ifportofolio.com/laporan8.html', 9),
  ('web-programming', 'UI Implementation and Simple CRUD', 'web-ui-simple-crud', 'Web basics', 1, 'https://zann.ifportofolio.com/laporan.html', 10)
) as v (course_slug, title, slug, label, number, legacy_url, age)
join public.courses c on c.slug = v.course_slug
on conflict (slug) do nothing;

update public.reports
set summary = 'ResepKu, my recipe app in Flutter, gets list and grid views, recipe photos, and bundled assets.',
    cover_url = '/images/reports/resepku-grid.jpg'
where slug = 'mobile-app-07-list-grid-images-assets' and summary = '' and cover_url is null;

-- ---------------------------------------------------------------------------
-- After creating your login under Authentication > Users, make it an admin
-- by running this one line with your own email:
--
--   insert into public.admins (user_id)
--   select id from auth.users where email = 'you@example.com';
-- ---------------------------------------------------------------------------
