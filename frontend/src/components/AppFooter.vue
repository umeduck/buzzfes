<template>
<!-- フッター (PCのみ) -->
  <v-footer
    app
    class="d-none d-md-flex justify-space-between px-6"
    color="grey-lighten-4"
  >
    <p class="text-caption">利用規約 プライバシーポリシー</p>
    <div class="d-flex gap-4">
      <v-icon>mdi-twitter</v-icon>
      <v-icon>mdi-facebook</v-icon>
      <v-icon>mdi-instagram</v-icon>
    </div>
  </v-footer>

  <!-- モバイル用ボトムナビ -->
  <v-bottom-navigation
    app
    grow
    class="d-md-none"
    color="blue-darken-3"
    active-color="white"
  >
    <v-btn>
      <v-icon>mdi-home</v-icon>
      ホーム
    </v-btn>
    <v-btn>
      <v-icon>mdi-trophy</v-icon>
      ランキング
    </v-btn>
    <v-btn>
      <v-icon>mdi-plus</v-icon>
      投稿
    </v-btn>
    <v-btn>
      <v-icon>mdi-bell</v-icon>
      お知らせ
    </v-btn>
  </v-bottom-navigation>
</template>