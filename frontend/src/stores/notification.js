import { defineStore } from 'pinia'

export const useNotificationStore = defineStore('notification', {
  state: () => ({
    message: '',
    color: 'success',
    show: false,
  }),
  actions: {
    notify(message, color = 'success') {
      this.message = message
      this.color = color
      this.show = true
    },
    close() {
      this.show = false
    },
  },
})