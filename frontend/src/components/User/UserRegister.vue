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
</template>

<script setup>
import { ref } from 'vue'
import api from '@/plugins/axios'
import { rules } from '@/stores/formRules'
import { useNotificationStore } from '@/stores/notification'

// ダイアログの開閉状態
const isDialogOpen = ref(false)

// フォームデータ
const login = ref({ name: '', email: '', password: '' })

// フォームのバリデーション状態
const isValid = ref(false)

// お知らせアラート
const notify = useNotificationStore()

const submitLogin = () => {
  const data = {
    name: login.value.name,
    email: login.value.email,
    password: login.value.password,
    password_confirmation: login.value.password,
    confirm_success_url: `http://localhost:8080`
  }
  api.post("http://localhost:3000/auth",data)
  .then(() => {
    isDialogOpen.value = false
    notify.notify('確認メールを送付しました。', 'success')
  })
  .catch(error => {
    if (error.response) {
      const status = error.response.status

      if (status === 422 && error.response.data.errors) {
        // バリデーションエラー
        const messages = error.response.data.errors.full_messages
        notify.notify(messages, 'error')
      } else {
        // その他のエラー
        notify.notify("システムエラーが発生しました", 'error')
      }
    } else {
      // ネットワークエラーやサーバー無応答
      notify.notify("サーバーに接続ができませんでした。", 'error')
    }
  })
}
</script>