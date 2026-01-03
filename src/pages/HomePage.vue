<template>
  <div class="min-h-screen bg-gradient-to-br from-background to-secondary-light">
    <!-- Header -->
    <header class="border-b border-border bg-background sticky top-0 z-10 shadow-sm">
      <nav class="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
        <div class="text-2xl font-bold text-primary">Prepico Blogs</div>
        <div class="flex gap-6 items-center">
          <router-link to="/blogs" class="text-foreground hover:text-primary font-medium transition">Blog</router-link>
          <router-link to="/admin" class="bg-primary text-white px-4 py-2 rounded-lg hover:opacity-90 transition">Write</router-link>
        </div>
      </nav>
    </header>

    <!-- Hero Section -->
    <main class="max-w-6xl mx-auto px-6 py-20">
      <div class="text-center mb-16">
        <h1 class="text-5xl font-bold text-foreground mb-4 text-balance">Insights for Career Optimization</h1>
        <p class="text-xl text-secondary mb-8 text-balance">Discover articles on professional development, career strategy, and industry insights.</p>
        <router-link to="/blogs" class="inline-block bg-primary text-white px-8 py-3 rounded-lg hover:opacity-90 transition font-medium">
          Read Articles
        </router-link>
      </div>

      <!-- Featured Articles Grid -->
      <div v-if="featuredBlogs.length > 0" class="grid md:grid-cols-2 gap-8">
        <article
          v-for="blog in featuredBlogs"
          :key="blog.id"
          class="bg-white rounded-xl shadow-sm hover:shadow-md transition overflow-hidden"
        >
          <img :src="blog.image_url" :alt="blog.title" class="w-full h-48 object-cover">
          <div class="p-6">
            <h2 class="text-2xl font-bold text-foreground mb-2">{{ blog.title }}</h2>
            <p class="text-secondary mb-4">{{ blog.excerpt }}</p>
            <div class="flex justify-between items-center text-sm text-secondary mb-4">
              <span>{{ blog.author_name }}</span>
              <span>{{ formatDate(blog.created_at) }}</span>
            </div>
            <router-link
              :to="`/blogs/${blog.id}`"
              class="text-primary font-medium hover:underline inline-block"
            >
              Read More →
            </router-link>
          </div>
        </article>
      </div>

      <!-- Loading State -->
      <div v-else-if="blogStore.isLoading" class="text-center py-20">
        <p class="text-secondary text-lg">Loading articles...</p>
      </div>

      <!-- Empty State -->
      <div v-else class="text-center py-20">
        <p class="text-secondary text-lg mb-4">No articles yet.</p>
      </div>
    </main>
  </div>
</template>

<script setup>
import { computed, onMounted } from "vue"
import { useBlogStore } from "../stores/blogStore"

const blogStore = useBlogStore()

// Load blogs on component mount
onMounted(async () => {
  await blogStore.fetchBlogs()
})

const featuredBlogs = computed(() => blogStore.blogs.slice(0, 2))

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  })
}
</script>
