<template>
    <v-dialog max-width="500" v-model = "isDialogOpen">
    <template v-slot:activator="{ props: activatorProps }">
      <v-btn
        v-bind="activatorProps"
        variant="outlined"
        color="grey"
        text="新規登録"
      ></v-btn>
    </template>

    <template v-slot:default="{ isActive }">
      <v-card title="新規登録">
        <v-card-text>
          <v-form ref="loginForm" v-model="isValid" @submit.prevent>
          <v-text-field
            label="ユーザー名"
            v-model="login.name"
            :rules="[rules.required]"
            required
          />
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
            text="新規登録"
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

// ダイアログの開閉状態
const isDialogOpen = ref(false) 

// フォームデータ
const login = ref({ name: '', email: '', password: '' })

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
    name: login.value.name,
    email: login.value.email,
    password: login.value.password,
    password_confirmation: login.value.password,
    confirm_success_url: `http://localhost:8080`
  }
  console.log(data)
  api.post("http://localhost:3000/auth",data)
  .then(response => {
    console.log(response.data)
    isDialogOpen.value = false
    snackbar.value = { visible: true, message: "確認メールを送付しました。", color: 'success' }
  })
  .catch(error => {
    if (error.response) {
      const status = error.response.status

      if (status === 422 && error.response.data.errors) {
        // バリデーションエラー
        const messages = error.response.data.errors.full_messages
        snackbar.value = { visible: true, message: messages, color: 'error' }
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