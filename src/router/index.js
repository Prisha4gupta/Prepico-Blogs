import { createRouter, createWebHistory } from "vue-router"
import HomePage from "../pages/HomePage.vue"
import BlogListPage from "../pages/BlogListPage.vue"
import BlogViewPage from "../pages/BlogViewPage.vue"
import AdminEditorPage from "../pages/AdminEditorPage.vue"

const routes = [
  {
    path: "/",
    name: "home",
    component: BlogListPage,
  },
  {
    path: "/blogs",
    name: "blog-list",
    component: BlogListPage,
  },
  {
    path: "/blogs/:id",
    name: "blog-view",
    component: BlogViewPage,
  },
  {
    path: "/admin",
    name: "admin",
    component: AdminEditorPage,
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
