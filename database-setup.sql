-- ============================================================
-- database-setup.sql  (نسخة محيّنة بالخانات الجديدة)
-- نسخ هاد الكود كامل، وألصقه ف Supabase → SQL Editor → Run
-- ============================================================

-- ===== جدول المنتجات / PRODUCTS =====
create table if not exists public.products (
  id           uuid primary key default gen_random_uuid(),
  name         text not null,
  tagline      text default '',
  price        numeric not null default 0,
  old_price    numeric default 0,
  description  text default '',
  images       jsonb default '[]'::jsonb,   -- صور المنتج (معرض)
  long_images  jsonb default '[]'::jsonb,   -- صور التفاصيل (الأسفل)
  benefits     jsonb default '[]'::jsonb,   -- المميزات (نقط)
  rating       numeric default 5,
  reviews      int default 0,
  sold         int default 0,
  created_at   timestamptz default now()
);

-- ===== جدول الطلبات / ORDERS =====
create table if not exists public.orders (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  phone       text not null,
  city        text,
  address     text not null,
  items       jsonb not null default '[]'::jsonb,
  total       numeric not null default 0,
  status      text not null default 'new',
  created_at  timestamptz default now()
);

-- ===== الحماية / Row Level Security =====
alter table public.products enable row level security;
alter table public.orders   enable row level security;

drop policy if exists products_read   on public.products;
drop policy if exists products_insert on public.products;
drop policy if exists products_update on public.products;
drop policy if exists products_delete on public.products;
create policy products_read   on public.products for select using (true);
create policy products_insert on public.products for insert with check (auth.role() = 'authenticated');
create policy products_update on public.products for update using (auth.role() = 'authenticated');
create policy products_delete on public.products for delete using (auth.role() = 'authenticated');

drop policy if exists orders_insert on public.orders;
drop policy if exists orders_read   on public.orders;
drop policy if exists orders_update on public.orders;
create policy orders_insert on public.orders for insert with check (true);
create policy orders_read   on public.orders for select using (auth.role() = 'authenticated');
create policy orders_update on public.orders for update using (auth.role() = 'authenticated');

-- ===== تخزين الصور / STORAGE BUCKET =====
insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do nothing;

drop policy if exists imgs_read   on storage.objects;
drop policy if exists imgs_insert on storage.objects;
drop policy if exists imgs_delete on storage.objects;
create policy imgs_read   on storage.objects for select using (bucket_id = 'product-images');
create policy imgs_insert on storage.objects for insert with check (bucket_id = 'product-images' and auth.role() = 'authenticated');
create policy imgs_delete on storage.objects for delete using (bucket_id = 'product-images' and auth.role() = 'authenticated');

-- سالا! Done.
