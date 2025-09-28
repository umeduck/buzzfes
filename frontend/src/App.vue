<template>
  <v-app>
    <AppHeader />
    <router-view />
  </v-app>
</template>

<script>
import { defineAsyncComponent } from 'vue'
export default {
  name: 'App',
  components: {
    AppHeader: defineAsyncComponent(() => import('./components/AppHeader.vue'))
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
