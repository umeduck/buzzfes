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
  <v-snackbar v-model="snackbar.visible" :color="snackbar.color" timeout="3000" location="top">
  {{ snackbar.message }}
</v-snackbar>
</template>

<script setup>
import { ref } from 'vue'
import api from '@/plugins/axios'
import { useAuthStore } from '@/stores/auth'

// ダイアログの開閉状態
const isDialogOpen = ref(false) 

// フォームデータ
const login = ref({ email: '', password: '' })

// フォームのバリデーション状態
const isValid = ref(false)

// バリデーションルール
const rules = {
  required: v => !!v || '必須項目です',
  email: v => /.+@.+\..+/.test(v) || 'メール形式で入力してください',
  min: l => v => (v && v.length >= l) || `${l}文字以上で入力してください`
}
// アラートメッセージ
const snackbar = ref('')

const submitLogin = () => {
  const data = {
    email: login.value.email,
    password: login.value.password
  }
  api.post("http://localhost:3000/auth/sign_in",data)
  .then(response => {
    snackbar.value = { visible: true, message: "ログインしました", color: 'success' }
    const authStore = useAuthStore()
    authStore.setAuthHeaders(response.headers)
  })
  .catch(error => {
    if (error.response) {
      const status = error.response.status

      if (status === 401) {
        // 認証エラー
        snackbar.value = { visible: true, message: "メールアドレスまたはパスワードが正しくありません。", color: 'error' }
      } else {
        // その他のエラー
        snackbar.value = { visible: true, message: "システムエラーが発生しました。時間をおいて再度お試しください。", color: 'error' }
      }
    } else {
      // ネットワークエラーやサーバー無応答
      snackbar.value = { visible: true, message: "サーバーに接続できませんでした。ネットワークを確認してください。", color: 'error' }
    }
  })
}
</script>