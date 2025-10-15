import { createRouter, createWebHistory } from 'vue-router'

// ページコンポーネントを import
import TopPage from '@/views/TopPage.vue'
import Theme from '@/components/Theme/index.vue'
import Post from '@/components/Post/index.vue'

// ルート定義
const routes = [
  { path: '/', name: 'TopPage', component: TopPage },
  { path: '/themes', name: 'ThemeIndex', component: Theme },
  { path: '/posts/:id', name: 'PostIndex', component: Post },
]

// Router インスタンスを作成
const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router