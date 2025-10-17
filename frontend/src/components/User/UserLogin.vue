<template>
  <v-dialog max-width="500" v-model = "isDialogOpen">
    <template v-slot:activator="{ props: activatorProps }">
      <v-btn
        v-bind="activatorProps"
        variant="outlined"
        color="grey"
        text="ログイン"
      ></v-btn>
    </template>

  <template v-slot:default="{ isActive }">
    <v-card title="ログイン">
      <v-card-text>
        <v-form ref="loginForm" v-model="isValid" @submit.prevent>
          <v-text-field
            label="メールアドレス"
            v-model="login.email"
            :rules="[rules.required, rules.email]"
            required
          />
          <v-text-field
            label="パスワード"
            v-model="login.password"
            type="password"
            :rules="[rules.required, rules.min(6)]"
            required
          />
        </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            text="閉じる"
            @click="isActive.value = false"
          ></v-btn>
          <v-btn
            text="ログイン"
            :disabled="!isValid"
            color="primary"
            @click="submitLogin">
          </v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script setup>
import { ref } from 'vue'
import api from '@/plugins/axios'
import { useAuthStore } from '@/stores/auth'
import { rules } from '@/stores/formRules'
import { useNotificationStore } from '@/stores/notification'

// ダイアログの開閉状態
const isDialogOpen = ref(false)

// フォームデータ
const login = ref({ email: '', password: '' })

// フォームのバリデーション状態
const isValid = ref(false)

// お知らせアラート
const notify = useNotificationStore()


const submitLogin = () => {
  const data = {
    email: login.value.email,
    password: login.value.password
  }
  api.post("http://localhost:3000/auth/sign_in",data)
  .then(response => {
    notify.notify('ログインしました', 'success')
    const authStore = useAuthStore()
    authStore.setAuthHeaders(response.headers)
  })
  .catch(error => {
    if (error.response) {
      const status = error.response.status

      if (status === 401) {
        // 認証エラー
        notify.notify('メールアドレスまたはパスワードが正しくありません。', 'error')
      } else {
        // その他のエラー
        notify.notify('システムエラーが発生しました。時間をおいて再度お試しください。', 'error')
      }
    } else {
      // ネットワークエラーやサーバー無応答
      notify.notify('サーバーに接続できませんでした。ネットワークを確認してください。', 'error')
    }
  })
}
</script>