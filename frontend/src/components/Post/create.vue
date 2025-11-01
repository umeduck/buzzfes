<template>
  <v-app>
    <v-main>
      <v-container class="mt-6">
        <h2 class="text-h5 font-weight-bold mb-4">投稿フォーム</h2>
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
        <v-row justify="center">
          <v-col cols="12" md="8">
            <v-card class="mb-4" elevation="2">
              <v-card-text>
                <v-form>
                  <v-text-field
                    label="タイトル"
                    v-model="title"
                    :rules="[rules.required]"
                    required
                    >
                  </v-text-field>
                  <v-textarea
                    label="内容"
                    v-model="content"
                    :rules="[rules.required]"
                    required
                  >
                  </v-textarea>
                  <v-btn color="blue-darken-3" class="mx-2" dark rounded :to="`/posts/${themeId}`">戻る</v-btn>
                  <v-btn color="blue-darken-3" class="mx-2" dark rounded @click="test">プレビュー</v-btn>
                  <v-btn v-if="postId" color="blue-darken-3" class="mx-2" dark rounded @click="submitPost">更新する</v-btn>
                  <v-btn v-else color="blue-darken-3" class="mx-2" dark rounded @click="submitPost">投稿する</v-btn>
                </v-form>
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
import { rules } from '@/stores/formRules'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useNotificationStore } from '@/stores/notification'

const route = useRoute()
const router = useRouter()
const auth = useAuthStore()
// お題
const theme = ref()

// お題ID
const themeId = route.params.themeId

// 投稿
const postId = route.params.postId

// フォーム情報
const title = ref('')
const content = ref('')

// お知らせアラート
const notify = useNotificationStore()

const checkLogin = async () => {
  if (!auth.isLoggedIn) {
    window.location.href = "/"
  }
}

const getTheme = async () => {
  api.get(`http://localhost:3000/themes/${themeId}`)
  .then(response => {
    theme.value = response.data
  })
  .catch(error => {
    console.error("Error fetching themes:", error)
  })
  if (postId) {
    api.get(`http://localhost:3000/posts/${postId}`)
    .then(response => {
      title.value = response.data.post.title
      content.value = response.data.post.content
    })
    .catch(error => {
      console.error("Error fetching themes:", error)
    })
  }
}

const submitPost = async () => {
  if (!auth.isLoggedIn) {
    window.location.href = "/"
    return
  }
  if (postId) {
    // ここでAPIからお題データを取得する処理を実装
    api.put(`http://localhost:3000/posts/${postId}`, {
      title: title.value,
      content: content.value,
      theme_id: themeId,
    })
    .then(() => {
      notify.notify('投稿が更新されました！', 'success')
      router.push(`/posts/${themeId}`)
    })
    .catch(error => {
      if (error.response && error.response.status == 409) {
        notify.notify(error.response.data.error, 'error')
      } else {
        notify.notify('投稿の更新に失敗しました。管理者に問い合わせを行います。', 'error')
      }
      router.push(`/posts/${themeId}`)
    })
    return
  } else {
    // ここでAPIからお題データを取得する処理を実装
    api.post("http://localhost:3000/posts", {
      title: title.value,
      content: content.value,
      theme_id: themeId,
    })
    .then(() => {
      notify.notify('投稿が完了しました！', 'success')
      router.push(`/posts/${themeId}`)
    })
    .catch(error => {
      if (error.response && error.response.status == 409) {
        notify.notify(error.response.data.error, 'error')
      } else {
        notify.notify('投稿に失敗しました。管理者に問い合わせを行います。', 'error')
      }
      router.push(`/posts/${themeId}`)
    })
  }
}

onMounted(() => {
  checkLogin()
  getTheme()
})
</script>