<template>
  <!-- ヘッダー (PC表示) -->
  <v-app-bar
    style="background-color: #BCEBFA;"
    dark
    height="70"
    class="d-none d-md-flex"
  >
    <v-img :src="require('@/assets/logo.png')" />
    <v-spacer></v-spacer>
    <v-btn text>ランキング</v-btn>
    <v-btn text>投稿</v-btn>
    <Register />
    <Login />
  </v-app-bar>

  <!-- ヘッダー (モバイル表示) -->
  <v-app-bar
    style="background-color: #BCEBFA;"
    dark
    density="comfortable"
    :style="{ top: '0' }"
  >
    <v-img :src="require('@/assets/logo.png')" />
    <v-spacer></v-spacer>
    <v-btn icon>
      <v-icon>mdi-menu</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script setup>
import Login from '@/components/User/UserLogin.vue'
import Register from '@/components/User/UserRegister.vue'
</script>