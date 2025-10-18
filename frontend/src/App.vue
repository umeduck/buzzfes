<template>
  <v-app>
    <AppHeader />
      <v-snackbar
        v-model="store.show"
        :color="store.color"
        timeout="3000"
        location="top"
      >
        {{ store.message }}
      </v-snackbar>
    <router-view />
    <AppFooter />
  </v-app>
</template>

<script>
import { defineAsyncComponent } from 'vue'
import { useNotificationStore } from '@/stores/notification'

export default {
  name: 'App',
  components: {
    AppHeader: defineAsyncComponent(() => import('./components/AppHeader.vue')),
    AppFooter: defineAsyncComponent(() => import('./components/AppFooter.vue'))
  },
  data() {
    return {
      store: useNotificationStore()
    }
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
