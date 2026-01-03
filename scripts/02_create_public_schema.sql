-- Create blogs table with public read/write policies (no authentication required)
CREATE TABLE IF NOT EXISTS blogs (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  excerpt TEXT NOT NULL,
  author_name TEXT NOT NULL DEFAULT 'Anonymous',
  image_url TEXT,
  content JSONB DEFAULT '[]'::jsonb,
  status TEXT DEFAULT 'published',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index on frequently queried fields
CREATE INDEX IF NOT EXISTS idx_blogs_slug ON blogs(slug);
CREATE INDEX IF NOT EXISTS idx_blogs_created_at ON blogs(created_at DESC);

-- Disable RLS - allow public read/write
ALTER TABLE blogs DISABLE ROW LEVEL SECURITY;

-- Drop old RLS policies if they exist
DROP POLICY IF EXISTS "Allow public read" ON blogs;
DROP POLICY IF EXISTS "Allow authenticated create" ON blogs;
DROP POLICY IF EXISTS "Allow authors to update" ON blogs;
DROP POLICY IF EXISTS "Allow authors to delete" ON blogs;

-- Drop profiles table and related policies if they exist
DROP TABLE IF EXISTS profiles CASCADE;
