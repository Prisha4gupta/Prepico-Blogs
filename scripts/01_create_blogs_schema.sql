-- Create blogs table for storing blog articles
create table if not exists public.blogs (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text not null unique,
  excerpt text not null,
  author_id uuid not null references auth.users(id) on delete cascade,
  author_name text not null,
  content jsonb not null default '[]'::jsonb,
  image_url text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create index on slug for faster lookups
create index if not exists idx_blogs_slug on public.blogs(slug);
create index if not exists idx_blogs_created_at on public.blogs(created_at desc);
create index if not exists idx_blogs_author_id on public.blogs(author_id);

-- Enable Row Level Security
alter table public.blogs enable row level security;

-- RLS Policies for blogs table
-- Allow anyone to read published blogs
create policy "Anyone can view blogs"
  on public.blogs for select
  using (true);

-- Allow authenticated users to create their own blogs
create policy "Users can create blogs"
  on public.blogs for insert
  with check (auth.uid() = author_id);

-- Allow users to update their own blogs
create policy "Users can update own blogs"
  on public.blogs for update
  using (auth.uid() = author_id)
  with check (auth.uid() = author_id);

-- Allow users to delete their own blogs
create policy "Users can delete own blogs"
  on public.blogs for delete
  using (auth.uid() = author_id);

-- Create profiles table for user information
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  bio text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable RLS on profiles
alter table public.profiles enable row level security;

-- RLS Policies for profiles
create policy "Public profiles are viewable by everyone"
  on public.profiles for select
  using (true);

create policy "Users can update own profile"
  on public.profiles for update
  using (auth.uid() = id);

create policy "Users can insert own profile"
  on public.profiles for insert
  with check (auth.uid() = id);

-- Create function to auto-create profile on user signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'display_name', new.email)
  )
  on conflict (id) do nothing;

  return new;
end;
$$ language plpgsql security definer set search_path = public;

-- Drop existing trigger if it exists
drop trigger if exists on_auth_user_created on auth.users;

-- Create trigger for automatic profile creation
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
