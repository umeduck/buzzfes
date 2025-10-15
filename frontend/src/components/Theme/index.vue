<template>
  <v-app>
    <v-main>
      <v-container class="mt-6">
        <h2 class="text-h5 font-weight-bold mb-4">お題一覧</h2>
        <v-row>
          <v-col cols="12" md="6" v-for="n in temeas" :key="n">
            <v-card class="mb-4" elevation="2">
              <v-card-text class="text-center">
                <h3 class="text-h6 font-weight-bold mb-4">{{ n.title }}</h3>
                <p class="mb-4">{{ n.description }}</p>
                <v-btn color="blue-darken-3" :to="`/posts/${n.id}`">参加する</v-btn>
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

const temeas = ref([])

const getTemes = async () => {
  // ここでAPIからお題データを取得する処理を実装
  api.get("http://localhost:3000/themes")
  .then(response => {
    temeas.value = response.data
  })
  .catch(error => {
    console.error("Error fetching themes:", error)
  })
}

onMounted(() => {
  getTemes()
})
</script>