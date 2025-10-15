<template>
  <v-app>
    <v-main>
      <v-container class="mt-6">
        <v-card class="mb-4" elevation="2">
          <v-card-text class="text-center">
            <div v-if="theme">
              <h3 class="text-h6 font-weight-bold mb-4">お題：{{ theme.title }}</h3>
              <p>{{ theme.description }}</p>
              <div v-if="auth.isLoggedIn">
                <v-btn color="blue-darken-3" dark rounded>投稿する</v-btn>
              </div>
              <div v-else>
                <v-btn color="grey-darken-3" dark rounded disable>投稿にはログインが必要です</v-btn>
              </div>
            </div>
          </v-card-text>
        </v-card>
        <h2 class="text-h5 font-weight-bold mb-4">投稿一覧</h2>
        <v-row>
          <v-col cols="12" md="6" v-for="n in posts" :key="n">
            <v-card class="mb-4" elevation="2">
              <v-card-text class="text-center">
                <h3 class="text-h6 font-weight-bold mb-4">{{ n.title }}</h3>
                <p class="mb-4">{{ n.content }}</p>
                <v-btn color="blue-darken-3" dark rounded>詳細を見る</v-btn>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup>
import { ref,onMounted } from 'vue'
import api from '@/plugins/axios'
import { useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const auth = useAuthStore()

const route = useRoute()
const id = route.params.id

const theme = ref()
const posts = ref([])
const my_post = ref(null)

const getTheme = async () => {
  api.get(`http://localhost:3000/themes/${id}`)
  .then(response => {
    theme.value = response.data
  })
  .catch(error => {
    console.error("Error fetching themes:", error)
  })
}

const getPosts = async () => {
  const data = {
    theme_id: id
  }
  api.get("http://localhost:3000/posts",{params: data})
  .then(response => {
    console.log(response.data)
    posts.value = response.data.posts
    my_post.value = response.data.my_post
  })
  .catch(error => {
    console.error("Error fetching themes:", error)
  })
}

onMounted(() => {
  getTheme()
  getPosts()
})
</script>