<template>
  <div class="min-h-screen bg-background">
    <!-- Header -->
    <header class="border-b border-border bg-background sticky top-0 z-10 shadow-sm">
      <nav class="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
        <router-link to="/" class="text-2xl font-bold text-primary">Prepico Blogs</router-link>
        <router-link to="/blogs" class="text-foreground hover:text-primary transition font-medium">
          View All Articles
        </router-link>
      </nav>
    </header>

    <!-- Editor -->
    <main class="max-w-4xl mx-auto px-6 py-12">
      <h1 class="text-4xl font-bold text-foreground mb-8">Create New Article</h1>

      <!-- Added error and success messages -->
      <div v-if="successMessage" class="bg-success-light text-success px-4 py-2 rounded-lg mb-6">
        {{ successMessage }}
      </div>
      <div v-if="errorMessage" class="bg-error-light text-error px-4 py-2 rounded-lg mb-6">
        {{ errorMessage }}
      </div>

      <form @submit.prevent="saveBlog" class="space-y-8">
        <!-- Title -->
        <div>
          <label class="block text-foreground font-bold mb-2">Title</label>
          <input
            v-model="formData.title"
            type="text"
            placeholder="Article title"
            class="w-full px-4 py-2 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            required
          />
        </div>

        <!-- Slug -->
        <div>
          <label class="block text-foreground font-bold mb-2">Slug</label>
          <input
            v-model="formData.slug"
            type="text"
            placeholder="article-slug"
            class="w-full px-4 py-2 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            required
          />
        </div>

        <!-- Excerpt -->
        <div>
          <label class="block text-foreground font-bold mb-2">Excerpt</label>
          <textarea
            v-model="formData.excerpt"
            placeholder="Brief summary of the article"
            rows="2"
            class="w-full px-4 py-2 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary resize-none"
            required
          ></textarea>
        </div>

        <!-- Author Name -->
        <div>
          <label class="block text-foreground font-bold mb-2">Author Name</label>
          <input
            v-model="formData.author_name"
            type="text"
            placeholder="Your name"
            class="w-full px-4 py-2 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            required
          />
        </div>

        <!-- Image URL -->
        <div>
          <label class="block text-foreground font-bold mb-2">Featured Image URL</label>
          <input
            v-model="formData.image_url"
            type="url"
            placeholder="https://example.com/image.jpg"
            class="w-full px-4 py-2 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
            required
          />
        </div>

        <!-- Content Blocks -->
        <div>
          <label class="block text-foreground font-bold mb-4">Content Blocks</label>
          <div class="space-y-4 mb-4">
            <div
              v-for="(block, index) in formData.content"
              :key="index"
              class="border border-border rounded-lg p-4 bg-secondary-light"
            >
              <div class="flex justify-between items-center mb-3">
                <select
                  v-model="block.type"
                  class="px-3 py-1 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                >
                  <option value="heading">Heading</option>
                  <option value="paragraph">Paragraph</option>
                  <option value="quote">Quote</option>
                  <option value="list">List</option>
                </select>
                <button
                  type="button"
                  @click="removeBlock(index)"
                  class="text-error hover:text-error font-medium"
                >
                  Remove
                </button>
              </div>

              <textarea
                v-if="block.type !== 'list'"
                v-model="block.content"
                placeholder="Block content"
                rows="3"
                class="w-full px-3 py-2 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary resize-none"
              ></textarea>

              <div v-else class="space-y-2">
                <div v-for="(item, i) in (block.items || [])" :key="i" class="flex gap-2">
                  <input
                    v-model="block.items[i]"
                    type="text"
                    placeholder="List item"
                    class="flex-1 px-3 py-2 border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                  />
                  <button
                    type="button"
                    @click="block.items.splice(i, 1)"
                    class="text-error hover:text-error"
                  >
                    ×
                  </button>
                </div>
                <button
                  type="button"
                  @click="addListItem(block)"
                  class="text-primary hover:underline text-sm"
                >
                  + Add Item
                </button>
              </div>
            </div>
          </div>

          <button
            type="button"
            @click="addBlock"
            class="text-primary hover:underline font-medium"
          >
            + Add Block
          </button>
        </div>

        <!-- Submit -->
        <div class="flex gap-4">
          <button
            type="submit"
            :disabled="blogStore.isLoading"
            class="bg-primary text-white px-8 py-3 rounded-lg hover:opacity-90 transition font-medium disabled:opacity-50"
          >
            {{ blogStore.isLoading ? "Publishing..." : "Publish Article" }}
          </button>
          <router-link
            to="/blogs"
            class="px-8 py-3 rounded-lg border border-border text-foreground hover:bg-secondary-light transition font-medium"
          >
            Cancel
          </router-link>
        </div>
      </form>
    </main>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue"
import { useRouter } from "vue-router"
import { useBlogStore } from "../stores/blogStore"

const router = useRouter()
const blogStore = useBlogStore()

const successMessage = ref("")
const errorMessage = ref("")

const formData = reactive({
  title: "",
  slug: "",
  excerpt: "",
  author_name: "",
  image_url: "",
  content: [{ type: "heading", content: "" }],
})

const addBlock = () => {
  formData.content.push({ type: "paragraph", content: "" })
}

const removeBlock = (index) => {
  formData.content.splice(index, 1)
}

const addListItem = (block) => {
  if (!block.items) {
    block.items = []
  }
  block.items.push("")
}

const saveBlog = async () => {
  successMessage.value = ""
  errorMessage.value = ""

  // 1. Validate Inputs
  if (!formData.title || !formData.title.trim()) {
    errorMessage.value = "Title is required"
    return
  }
  if (!formData.slug || !formData.slug.trim()) {
    errorMessage.value = "Slug is required"
    return
  }
  if (!formData.excerpt || !formData.excerpt.trim()) {
    errorMessage.value = "Excerpt is required"
    return
  }
  if (!formData.author_name || !formData.author_name.trim()) {
    errorMessage.value = "Author name is required"
    return
  }
  if (formData.content.length === 0 || !formData.content.some(block => block.content || (block.items && block.items.length > 0))) {
    errorMessage.value = "At least one content block with text is required"
    return
  }

  try {
    // 2. Construct Blog Payload
    // Note: Mapping to database schema which uses 'image_url', though prompt mentioned 'featured_image_url'
    // We stick to the existing store pattern and likely DB column 'image_url' unless mapped in store.
    const payload = {
      title: formData.title,
      slug: formData.slug,
      excerpt: formData.excerpt,
      author_name: formData.author_name,
      image_url: formData.image_url,
      content: formData.content,
      status: "published"
    }

    await blogStore.addBlog(payload)

    // 3. Handle Success
    successMessage.value = "Article published successfully!"
    
    // Reset form
    formData.title = ""
    formData.slug = ""
    formData.excerpt = ""
    formData.author_name = ""
    formData.image_url = ""
    formData.content = [{ type: "heading", content: "" }]

    setTimeout(() => {
      router.push("/blogs")
    }, 1500)
  } catch (err) {
    // 4. Handle Errors
    console.error("Publish error:", err)
    errorMessage.value = err.message || "Failed to publish article"
  }
}
</script>
