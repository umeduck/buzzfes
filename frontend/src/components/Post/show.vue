<template>
  <v-app>
    <v-main>
      <v-container class="my-6">
        <h2 class="text-h5 font-weight-bold mb-4">投稿詳細</h2>
        <v-row justify="center">
          <v-col cols="12" md="8">
            <v-card elevation="2">
              <v-card-text>
                <div v-if="theme">
                  <h3 class="text-h6 font-weight-bold mb-4">お題：{{ theme.title }}</h3>
                  <p>{{ theme.description }}</p>
                </div>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
      <v-container class="my-6">
        <v-card class="mb-4" elevation="2">
          <v-card-text>
            <div v-if="post">
              <h3 class="text-h6 font-weight-bold mb-4">タイトル：{{ post.title }}</h3>
              <p class="text-body-1">{{ post.content }}</p>
              <p class="my-6 text-right">投稿者: {{ post.user_name }}</p>
            </div>
            <v-btn v-if="voteStatus==0"  color="blue-darken-3" @click="submitVote">投票する</v-btn>
            <v-btn v-else-if="voteStatus==1"  color="gray-3" disabled>投票済み</v-btn>
            <v-btn v-else-if="voteStatus==2"  color="blue-darken-3" @click="confirmVote">投票する</v-btn>
          </v-card-text>
        </v-card>
      </v-container>
    </v-main>
  </v-app>
</template>
<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import api from '@/plugins/axios'
import { useNotificationStore } from '@/stores/notification'

const route = useRoute()

const postId = route.params.postId

const theme = ref()
const post = ref()

// お知らせアラート
const notify = useNotificationStore()

// 投稿済みデータ 0:未投票 1:投票済み 2:別の投稿に投票済み
const voteStatus = ref(0)

const getPost = async () => {
  api.get(`http://localhost:3000/posts/${postId}`)
  .then(response => {
    theme.value = response.data.theme
    post.value = response.data.post
    voteStatus.value = response.data.vote_status
  })
  .catch(error => {
    console.error("Error fetching post:", error)
  })
}

const confirmVote = () => {
  if (confirm("他の投稿に投票しています。投票を変更しますか？")) {
    submitVote()
  }
}

const submitVote = () => {
  api.put((`http://localhost:3000/votes/${postId}`))
  .then(response => {
    notify.notify('投票完了', 'success')
    voteStatus.value = response.data.vote_status
  })
  .catch(error => {
    console.error("Error fetching post:", error)
  })
}

onMounted(() => {
  getPost()
})
</script>