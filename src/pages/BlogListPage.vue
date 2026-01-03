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

    <!-- Blog List -->
    <main class="max-w-6xl mx-auto px-6 py-12">
      <div class="mb-12">
        <h1 class="text-4xl font-bold text-foreground mb-2 text-balance">All Articles</h1>
        <p class="text-secondary text-lg text-balance">Explore our collection of articles on career optimization and professional development.</p>
      </div>

      <!-- Loading State -->
      <div v-if="blogStore.isLoading" class="text-center py-12">
        <p class="text-secondary text-lg">Loading articles...</p>
      </div>

      <!-- Grid Layout for Blog List -->
      <div v-else-if="blogStore.blogs.length > 0" class="grid md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
        <article
          v-for="blog in blogStore.blogs"
          :key="blog.id"
          class="bg-white border border-border rounded-xl overflow-hidden hover:shadow-lg transition flex flex-col"
        >
          <!-- Image -->
          <img :src="blog.image_url" :alt="blog.title" class="w-full h-48 object-cover">
          
          <!-- Content -->
          <div class="p-6 flex flex-col flex-1">
            <router-link :to="`/blogs/${blog.id}`" class="block group">
              <h2 class="text-xl font-bold text-foreground group-hover:text-primary transition mb-2 text-balance">
                {{ blog.title }}
              </h2>
            </router-link>
            
            <p class="text-secondary text-sm mb-4 flex-1">
              {{ blog.excerpt }}
            </p>
            
            <!-- Metadata -->
            <div class="border-t border-border pt-4">
              <div class="flex justify-between items-center text-xs text-secondary mb-4">
                <span class="font-medium">{{ blog.author_name }}</span>
                <span>{{ formatDate(blog.created_at) }}</span>
              </div>
              
              <router-link
                :to="`/blogs/${blog.id}`"
                class="text-primary hover:underline font-medium text-sm inline-block"
              >
                Read More →
              </router-link>
            </div>
          </div>
        </article>
      </div>

      <!-- Empty state -->
      <div v-else class="text-center py-20">
        <p class="text-secondary text-xl mb-4">No articles yet.</p>
        <router-link to="/admin" class="text-primary hover:underline font-medium">Create the first one!</router-link>
      </div>
    </main>
  </div>
</template>

<script setup>
import { onMounted } from "vue"
import { useBlogStore } from "../stores/blogStore"

const blogStore = useBlogStore()

// Load blogs on mount
onMounted(async () => {
  await blogStore.fetchBlogs()
})

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  })
}
</script>
