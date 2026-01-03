# Prepico Blogs

A modern, production-ready blog platform built with Vue.js 3, Vite, Tailwind CSS, and Supabase. Features a responsive design, block-based content editor, and a dynamic backend for managing articles.

---

## 🚀 Features

*   **Modern Visuals**: Mobile-first design inspired by Prepico.ai, featuring glassmorphism, beautiful gradients, and a curated HSL color palette.
*   **Block-Based Editor**: Intuitive admin interface to create articles with headings, paragraphs, formatted lists, and quotes.
*   **Dynamic Data**: Fully integrated with Supabase for real-time data persistence and storage.
*   **High Performance**: Powered by Vite and Vue 3 for lightning-fast loads and smooth transitions.
*   **State Management**: Centralized data handling using Pinia.
*   **SEO Optimized**: Semantic HTML structure and responsive layouts.

---

## 🛠️ Tech Stack

*   **Frontend**: Vue 3 (Composition API), Vite, Vue Router
*   **State Management**: Pinia
*   **Styling**: Tailwind CSS (v3 with Custom Design Tokens)
*   **Backend & Database**: Supabase (PostgreSQL)

---

## 📦 Project Structure

```bash
src/
├── main.js              # App entry point
├── App.vue              # Root component
├── style.css            # Tailwind CSS imports & Design Tokens
├── router/
│   └── index.js         # Client-side routing configuration
├── stores/
│   └── blogStore.js     # Pinia store for Supabase interactions
├── lib/
│   └── supabase/        # Supabase client configuration
└── pages/
    ├── HomePage.vue          # Landing page with hero & featured articles
    ├── BlogListPage.vue      # Full archive of published articles
    ├── BlogViewPage.vue      # Single article reader
    └── AdminEditorPage.vue   # CMS for writing & publishing
```

---

## ⚡ Getting Started

### Prerequisites

*   Node.js 18+ installed
*   A Supabase account (free tier works perfectly)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Prisha4gupta/Prepico-Blogs.git
    cd prepico-blogs
    ```

2.  **Install dependencies:**
    ```bash
    npm install
    ```

3.  **Environment Setup:**
    Create a `.env` file in the root directory with your Supabase credentials:
    ```env
    VITE_SUPABASE_URL=your_supabase_project_url
    VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
    ```

4.  **Database Setup:**
    Go to your Supabase SQL Editor and run the initialization script located at `scripts/02_create_public_schema.sql` to create the necessary tables and policies.
    *   *Note: Ensure you also run `scripts/03_add_status_column.sql` if using a pre-existing table.*

5.  **Run Locally:**
    ```bash
    npm run dev
    ```

---
