import axios from 'axios'
import { useAuthStore } from '@/stores/auth'

// 💡 リクエスト時に自動で認証ヘッダを付与
const api = axios.create({
  baseURL: 'http://localhost:3000',
  headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
})

api.interceptors.request.use((config) => {
  const auth = useAuthStore()
  if (auth.isLoggedIn) {
    config.headers['access-token'] = auth.accessToken
    config.headers['client'] = auth.client
    config.headers['uid'] = auth.uid
  }
  return config
})

// 💡 レスポンスに新しいトークンが来たら自動で更新
api.interceptors.response.use((response) => {
  const auth = useAuthStore()
  const newToken = response.headers['access-token']
  if (newToken) {
    auth.setAuthHeaders(response.headers)
  }
  return response
}, (error) => {
  // 認証エラー（401など）が出たらログアウト処理など
  if (error.response?.status === 401) {
    const auth = useAuthStore()
    auth.logout()
  }
  return Promise.reject(error)
})


export default api