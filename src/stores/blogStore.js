import { defineStore } from "pinia"
import { ref, computed } from "vue"
import { supabase } from "../lib/supabase/client"

export const useBlogStore = defineStore("blog", () => {
  const blogs = ref([])
  const isLoading = ref(false)
  const error = ref(null)

  // Fetch all blogs from Supabase
  const fetchBlogs = async () => {
    isLoading.value = true
    error.value = null

    try {

      const { data, error: fetchError } = await supabase
        .from("blogs")
        .select("*")
        .order("created_at", { ascending: false })

      if (fetchError) throw fetchError

      blogs.value = data || []
    } catch (err) {
      console.error("Failed to fetch blogs:", err)
      error.value = err.message
      blogs.value = []
    } finally {
      isLoading.value = false
    }
  }

  // Add a new blog (no auth required)
  const addBlog = async (blog) => {
    isLoading.value = true
    error.value = null

    try {


      const { data, error: insertError } = await supabase
        .from("blogs")
        .insert([
          {
            title: blog.title,
            slug: blog.slug,
            excerpt: blog.excerpt,
            author_name: blog.author_name || "Anonymous",
            content: blog.content || [],
            image_url: blog.image_url,
            // Only add status if it's in the payload, assuming DB supports it or ignores extra fields if not strict (JSONB usually)
            // But this is a table insert. If column missing, it errors.
            // User requested explicit payload structure. I'll include it.
            // If it fails, we catch the error.
            ...(blog.status ? { status: blog.status } : {}),
            // featured_image_url: blog.featured_image_url // schema uses image_url
          },
        ])
        .select()

      if (insertError) throw insertError

      if (data && data.length > 0) {
        blogs.value.unshift(data[0])
      }

      return data?.[0]
    } catch (err) {
      console.error("Failed to add blog:", err)
      error.value = err.message
      throw err
    } finally {
      isLoading.value = false
    }
  }

  // Get blog by ID
  const getBlogById = (id) => {
    return blogs.value.find((blog) => blog.id == id)
  }

  // Get blog by slug
  const getBlogBySlug = (slug) => {
    return blogs.value.find((blog) => blog.slug === slug)
  }

  // Update blog (no auth required)
  const updateBlog = async (id, updates) => {
    isLoading.value = true
    error.value = null

    try {


      const { data, error: updateError } = await supabase
        .from("blogs")
        .update({
          ...updates,
          updated_at: new Date().toISOString(),
        })
        .eq("id", id)
        .select()

      if (updateError) throw updateError

      const index = blogs.value.findIndex((b) => b.id === id)
      if (index > -1 && data && data.length > 0) {
        blogs.value[index] = data[0]
      }

      return data?.[0]
    } catch (err) {
      console.error("Failed to update blog:", err)
      error.value = err.message
      throw err
    } finally {
      isLoading.value = false
    }
  }

  // Delete blog (no auth required)
  const deleteBlog = async (id) => {
    isLoading.value = true
    error.value = null

    try {


      const { error: deleteError } = await supabase.from("blogs").delete().eq("id", id)

      if (deleteError) throw deleteError

      const index = blogs.value.findIndex((b) => b.id === id)
      if (index > -1) {
        blogs.value.splice(index, 1)
      }
    } catch (err) {
      console.error("Failed to delete blog:", err)
      error.value = err.message
      throw err
    } finally {
      isLoading.value = false
    }
  }

  const allBlogs = computed(() => blogs.value)

  return {
    blogs: allBlogs,
    isLoading,
    error,
    fetchBlogs,
    addBlog,
    getBlogById,
    getBlogBySlug,
    updateBlog,
    deleteBlog,
  }
})
