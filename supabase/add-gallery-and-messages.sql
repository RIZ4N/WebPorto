-- Adds the gallery and the contact-form inbox.
-- Paste into Supabase > SQL Editor and press Run, after schema.sql.
-- Safe to run more than once.

-- ---------------------------------------------------------------------------
-- Gallery photos, shown on the home page in "position" order.
-- ---------------------------------------------------------------------------
create table if not exists public.gallery_photos (
  id uuid primary key default gen_random_uuid(),
  image_url text not null,
  caption text not null default '',
  position integer not null default 0,
  created_at timestamptz not null default now()
);

alter table public.gallery_photos enable row level security;
grant select on public.gallery_photos to anon, authenticated;
grant insert, update, delete on public.gallery_photos to authenticated;

drop policy if exists "gallery is public" on public.gallery_photos;
create policy "gallery is public" on public.gallery_photos
  for select using (true);

drop policy if exists "admins manage gallery" on public.gallery_photos;
create policy "admins manage gallery" on public.gallery_photos
  for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- The three photos from the old site, added only while the gallery is empty.
insert into public.gallery_photos (image_url, caption, position)
select v.image_url, v.caption, v.position
from (values
  ('/images/gallery/photo-1.webp', 'Terraced rice fields', 0),
  ('/images/gallery/photo-2.webp', 'Castle on a forested hill', 1),
  ('/images/gallery/photo-3.webp', 'Laptop with code on a desk', 2)
) as v (image_url, caption, position)
where not exists (select 1 from public.gallery_photos);

-- ---------------------------------------------------------------------------
-- Messages sent from the contact form.
-- Anyone may send one; only admins can read or delete them.
-- ---------------------------------------------------------------------------
create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(btrim(name)) between 1 and 120),
  email text not null check (char_length(email) between 5 and 200 and email like '%_@_%._%'),
  message text not null check (char_length(btrim(message)) between 1 and 4000),
  created_at timestamptz not null default now()
);

alter table public.messages enable row level security;
grant insert on public.messages to anon, authenticated;
grant select, delete on public.messages to authenticated;

drop policy if exists "anyone can send a message" on public.messages;
create policy "anyone can send a message" on public.messages
  for insert to anon, authenticated
  with check (true);

drop policy if exists "admins read messages" on public.messages;
create policy "admins read messages" on public.messages
  for select to authenticated
  using (public.is_admin());

drop policy if exists "admins delete messages" on public.messages;
create policy "admins delete messages" on public.messages
  for delete to authenticated
  using (public.is_admin());

-- A simple flood guard: at most 30 messages per hour in total.
create or replace function public.limit_messages()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if (select count(*) from public.messages where created_at > now() - interval '1 hour') >= 30 then
    raise exception 'Too many messages right now. Please try again later.'
      using errcode = 'P0001';
  end if;
  return new;
end;
$$;

drop trigger if exists limit_messages on public.messages;
create trigger limit_messages
  before insert on public.messages
  for each row execute function public.limit_messages();
