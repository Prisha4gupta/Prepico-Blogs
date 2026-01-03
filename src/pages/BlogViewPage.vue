<template>
  <div class="min-h-screen bg-background">
    <!-- Fixed header structure to avoid linting issues -->
    <header class="border-b border-border bg-background sticky top-0 z-10 shadow-sm">
      <nav class="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
        <router-link to="/" class="text-2xl font-bold text-primary">Prepico Blogs</router-link>
        <div class="flex gap-6 items-center">
          <router-link to="/blogs" class="text-foreground hover:text-primary font-medium transition">Blog</router-link>
          <router-link to="/admin" class="bg-primary text-white px-4 py-2 rounded-lg hover:opacity-90 transition">Write</router-link>
        </div>
      </nav>
    </header>

    <!-- Blog Content -->
    <main v-if="blog" class="max-w-3xl mx-auto px-6 py-12">
      <!-- Hero Image -->
      <img :src="blog.image_url" :alt="blog.title" class="w-full h-[28rem] object-cover rounded-xl mb-12 shadow-md">

      <!-- Article Header -->
      <header class="mb-12">
        <h1 class="text-5xl font-bold text-foreground mb-6 text-balance">{{ blog.title }}</h1>
        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-border pb-6">
          <div class="flex items-center gap-1 text-secondary">
            <span class="font-medium">By {{ blog.author_name }}</span>
          </div>
          <span class="text-secondary text-sm">{{ formatDate(blog.created_at) }}</span>
        </div>
      </header>

      <!-- Content Blocks -->
      <article class="prose prose-lg max-w-none space-y-8">
        <template v-for="(block, index) in blog.content" :key="index">
          <!-- Enhanced heading styling with better typography -->
          <h2 v-if="block.type === 'heading'" class="text-3xl font-bold text-foreground mt-0 pt-0">
            {{ block.content }}
          </h2>

          <!-- Improved paragraph styling with better line height and spacing -->
          <p v-else-if="block.type === 'paragraph'" class="text-lg text-secondary leading-relaxed text-balance">
            {{ block.content }}
          </p>

          <!-- Enhanced quote styling with left border and background -->
          <blockquote
            v-else-if="block.type === 'quote'"
            class="border-l-4 border-primary pl-6 py-4 bg-primary-light rounded-r-lg italic text-lg text-foreground"
          >
            "{{ block.content }}"
          </blockquote>

          <!-- Improved list styling with better spacing -->
          <ul v-else-if="block.type === 'list'" class="space-y-3">
            <li v-for="(item, i) in block.items" :key="i" class="flex gap-3 text-lg text-secondary">
              <span class="text-primary font-bold flex-shrink-0">•</span>
              <span>{{ item }}</span>
            </li>
          </ul>
        </template>
      </article>

      <!-- Navigation -->
      <nav class="mt-16 pt-12 border-t border-border">
        <router-link to="/blogs" class="inline-flex items-center gap-2 text-primary hover:text-primary font-medium group">
          <span class="group-hover:-translate-x-1 transition">←</span>
          Back to All Articles
        </router-link>
      </nav>
    </main>

    <!-- Not Found State -->
    <main v-else class="min-h-screen flex flex-col items-center justify-center">
      <h2 class="text-2xl font-bold text-foreground mb-4">Article not found</h2>
      <router-link to="/blogs" class="text-primary hover:underline font-medium">
        Return to articles
      </router-link>
    </main>
  </div>
</template>

<script setup>
import { computed, onMounted } from "vue"
import { useRoute } from "vue-router"
import { useBlogStore } from "../stores/blogStore"

const route = useRoute()
const blogStore = useBlogStore()

// Load blogs on mount
onMounted(async () => {
  await blogStore.fetchBlogs()
})

const blog = computed(() => {
  return blogStore.getBlogById(route.params.id)
})

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  })
}
</script>
