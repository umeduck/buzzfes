<template>
  <!-- ヘッダー (PC表示) -->
  <v-app-bar
    color="blue-darken-3"
    dark
    density="comfortable"
    class="d-none d-md-flex"
  >
    <v-toolbar-title class="text-h5 font-weight-bold">BuzzFes</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn text>ホーム</v-btn>
    <v-btn text>ランキング</v-btn>
    <v-btn text>投稿</v-btn>
    <v-btn variant="outlined" color="white">ログイン</v-btn>
  </v-app-bar>

  <!-- ヘッダー (モバイル表示) -->
  <v-app-bar
    color="blue-darken-3"
    dark
    density="comfortable"
    class="d-flex d-md-none"
  >
    <v-toolbar-title class="text-h6 font-weight-bold">BF</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon>
      <v-icon>mdi-menu</v-icon>
    </v-btn>
  </v-app-bar>

  <!-- コンテンツ -->
  <v-main>
    <v-container class="py-6">
      <!-- お題 -->
      <v-card class="mb-6" elevation="2">
        <v-card-text class="text-center">
          <h2 class="text-h5 font-weight-bold mb-4">#じゃがりこアレンジレシピ</h2>
          <v-btn color="blue-darken-3" dark rounded>参加する</v-btn>
        </v-card-text>
      </v-card>

      <!-- 投稿一覧 -->
      <h3 class="text-subtitle-1 font-weight-bold mb-4">投稿のテキスト</h3>
      <v-row>
        <v-col cols="12" md="6" lg="4" v-for="i in 3" :key="i">
          <v-card elevation="2" class="pa-3">
            <v-row no-gutters>
              <v-col cols="4">
                <v-sheet
                  class="d-flex align-center justify-center"
                  color="grey-lighten-3"
                  height="80"
                >
                  <v-icon size="32">mdi-image</v-icon>
                </v-sheet>
              </v-col>
              <v-col cols="8" class="pl-3">
                <p class="font-weight-medium">投稿のテキストが入ります</p>
                <p class="text-grey text-caption">ユーザー名</p>
                <div class="d-flex align-center mt-1">
                  <v-icon size="16" color="red">mdi-heart</v-icon>
                  <span class="ml-1 text-caption">24</span>
                  <v-icon size="16" class="ml-4">mdi-comment</v-icon>
                  <span class="ml-1 text-caption">3</span>
                </div>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>

      <!-- 人気の投稿 & ピックアップ -->
      <v-row class="mt-8">
        <v-col cols="12" md="6">
          <h3 class="text-subtitle-1 font-weight-bold mb-2">人気の投稿</h3>
          <div class="d-flex gap-2">
            <v-chip v-for="n in 4" :key="n" class="ma-1" color="grey-lighten-3">{{ n }}</v-chip>
          </div>
        </v-col>
        <v-col cols="12" md="6">
          <h3 class="text-subtitle-1 font-weight-bold mb-2">ピックアップ</h3>
          <v-sheet
            class="d-flex align-center justify-center"
            color="grey-lighten-3"
            height="120"
          >
            <v-icon size="40">mdi-image</v-icon>
          </v-sheet>
        </v-col>
      </v-row>
    </v-container>
  </v-main>

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

<script setup>
// Vuetify 3 を前提にしてます
</script>