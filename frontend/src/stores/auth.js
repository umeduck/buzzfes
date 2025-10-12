import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    uid: null,
    client: null,
    accessToken: null,
    expiry: null,
  }),
  getters: {
    isLoggedIn: (state) => !!state.accessToken,
  },
  actions: {
    setAuthHeaders(headers) {
      this.client = headers['client'];
      this.uid = headers['uid'];
      this.accessToken = headers['access-token'];
      this.expiry = headers['expiry'];
    },
    logout() {
      this.uid = null
      this.client = null
      this.accessToken = null
      this.expiry = null
      localStorage.removeItem('auth')
    }
  }
});