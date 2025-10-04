import axios from 'axios'

axios.defaults.baseURL = 'http://localhost:3000'  // APIのベースURL（必要なら）
axios.defaults.headers.common['Content-Type'] = 'application/json'
axios.defaults.headers.common['Accept'] = 'application/json'

export default axios