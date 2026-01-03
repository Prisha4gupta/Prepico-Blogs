-- Create blogs table
CREATE TABLE blogs (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  excerpt TEXT NOT NULL,
  author VARCHAR(255) NOT NULL,
  date DATE NOT NULL,
  image VARCHAR(500) NOT NULL,
  blocks JSONB NOT NULL DEFAULT '[]',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on slug for faster lookups
CREATE INDEX idx_blogs_slug ON blogs(slug);

-- Create index on date for sorting
CREATE INDEX idx_blogs_date ON blogs(date DESC);

-- Create blocks table for normalized content (optional - for more granular control)
CREATE TABLE blog_blocks (
  id BIGSERIAL PRIMARY KEY,
  blog_id BIGINT NOT NULL REFERENCES blogs(id) ON DELETE CASCADE,
  type VARCHAR(50) NOT NULL,
  content TEXT,
  items JSONB,
  position INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on blog_id for faster queries
CREATE INDEX idx_blog_blocks_blog_id ON blog_blocks(blog_id);

-- Create authors table for future expansion
CREATE TABLE authors (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  bio TEXT,
  avatar_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed initial data
INSERT INTO blogs (title, slug, excerpt, author, date, image, blocks) VALUES
(
  'Getting Started with Vue 3',
  'getting-started-with-vue-3',
  'Learn the fundamentals of Vue 3 and build modern web applications.',
  'Sarah Chen',
  '2025-01-15',
  'https://images.unsplash.com/photo-1633356122544-f134ef2944f1?w=800&h=400&fit=crop',
  '[
    {"type": "heading", "content": "Getting Started with Vue 3"},
    {"type": "paragraph", "content": "Vue 3 is a progressive JavaScript framework that makes building interactive user interfaces simple and enjoyable. In this guide, we will explore the core concepts and best practices."}
  ]'::JSONB
),
(
  'State Management with Pinia',
  'state-management-with-pinia',
  'Master state management in Vue 3 applications using Pinia.',
  'John Developer',
  '2025-01-10',
  'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&h=400&fit=crop',
  '[
    {"type": "heading", "content": "State Management with Pinia"},
    {"type": "paragraph", "content": "Pinia is a store library for Vue 3 with an API that is less verbose than Vuex and supports composition API."}
  ]'::JSONB
);

-- Create admin users table for authentication
CREATE TABLE admin_users (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
