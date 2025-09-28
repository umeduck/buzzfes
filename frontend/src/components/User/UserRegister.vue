<template>
    <v-dialog max-width="500">
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
          <v-form ref="loginForm" v-model="isValid">
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
          <v-btn color="primary" @click="submitLogin">新規登録</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script setup>
import { ref } from 'vue'
import axios from 'axios'

const login = ref({ name: '', email: '', password: '' })
const isValid = ref(false)

const rules = {
  required: v => !!v || '必須項目です',
  email: v => /.+@.+\..+/.test(v) || 'メール形式で入力してください',
  min: l => v => (v && v.length >= l) || `${l}文字以上で入力してください`
}

const submitLogin = () => {
  const data = {
    name: login.value.name,
    email: login.value.email,
    password_digest: login.value.password
  }
  axios.post("http://localhost:3000/users",data)
  .then(response => {
    console.log(response.data)
  })
  .catch(error => {
    console.error(error)
  })
}
</script>