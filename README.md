# Prepico Blogs

A production-ready blog platform built with Vue.js 3, Vite, and Pinia. Features a block-based content editor, responsive design, and modern UX inspired by Prepico.ai.

## Features

- **Vue 3 Composition API** - Modern reactive components with `<script setup>`
- **Block-Based Editor** - Create flexible article layouts with headings, paragraphs, quotes, and lists
- **Pinia State Management** - Centralized blog data management
- **Responsive Design** - Mobile-first design that works on all devices
- **Grid Layout** - Beautiful card-based blog listing with responsive columns
- **Rich Content Rendering** - Dynamic content block rendering with styled elements
- **Client-side Routing** - Fast navigation with Vue Router

## Project Structure

```
src/
├── main.js              # App entry point
├── App.vue              # Root component
├── style.css            # Tailwind CSS with design tokens
├── router/
│   └── index.js         # Vue Router configuration
├── stores/
│   └── blogStore.js     # Pinia store for blog data
└── pages/
    ├── HomePage.vue          # Homepage with featured articles
    ├── BlogListPage.vue      # All articles grid view
    ├── BlogViewPage.vue      # Individual article view
    └── AdminEditorPage.vue   # Blog editor interface
```

## Setup Instructions

### Prerequisites

- Node.js 16+ (recommended: 18 or higher)
- npm or yarn package manager

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd prepico-blogs
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

4. Open your browser and navigate to:
```
http://localhost:5173
```

## Development

### Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build for production
- `npm run preview` - Preview production build locally

### Project Dependencies

```json
{
  "vue": "^3.4.0",
  "vue-router": "^4.2.0",
  "pinia": "^2.1.0",
  "@vitejs/plugin-vue": "^5.0.0",
  "tailwindcss": "^4.0.0"
}
```

## Blog Structure

Each blog article contains:

```javascript
{
  id: 1,
  title: "Article Title",
  slug: "article-slug",
  excerpt: "Brief summary",
  author: "Author Name",
  date: "2025-01-15",
  image: "https://...",
  blocks: [
    { type: "heading", content: "Section Title" },
    { type: "paragraph", content: "Paragraph text" },
    { type: "quote", content: "Quote content" },
    { type: "list", items: ["Item 1", "Item 2"] }
  ]
}
```

## Creating a New Article

1. Navigate to `/admin`
2. Fill in article metadata:
   - Title
   - URL slug
   - Excerpt
   - Author name
   - Publication date
   - Featured image URL
3. Add content blocks:
   - Headings, paragraphs, quotes, and lists
   - Reorder or remove blocks as needed
4. Click "Publish Article" to save

## Styling

The project uses **Tailwind CSS v4** with custom design tokens:

- **Primary Color**: `#0066cc` (Professional blue)
- **Background**: `#ffffff`
- **Text**: `#1a1a1a`
- **Secondary**: `#6b7280` (Gray)
- **Border**: `#e5e7eb` (Light gray)

Design tokens are defined in `src/style.css` and can be customized to match your brand.

## Database Integration

The project includes a SQL schema (`scripts/01_create_schema.sql`) for production deployment:

- `blogs` table - Article metadata and block content
- `blog_blocks` table - Normalized content structure
- `authors` table - Author information
- `admin_users` table - Authentication

To use with a database:
1. Run the SQL schema in your database
2. Update the Pinia store to fetch from your API
3. Create API endpoints for CRUD operations

## Deployment

### Vercel (Recommended)

```bash
npm i -g vercel
vercel
```

### GitHub Pages

Build the project and push the `dist` folder.

## Color System

- **Primary**: Navy Blue (#0066cc) - Main brand color
- **Light Primary**: #e6f0ff - Subtle backgrounds
- **Secondary**: Gray (#6b7280) - Text and accents
- **Light Secondary**: #f3f4f6 - Subtle backgrounds
- **Border**: #e5e7eb - Dividers and borders

## Typography

- **Headings**: System font stack (Segoe UI, Roboto, etc.)
- **Body**: System font stack
- **Line Height**: 1.6 (optimized for readability)

## License

MIT

## Support

For issues, questions, or feature requests, please open an issue on GitHub.

---

Built with by the Prepico team.
