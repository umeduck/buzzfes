/* eslint-env node */
module.exports = {
  parser: "vue-eslint-parser",
  parserOptions: {
    ecmaVersion: 2020,
    sourceType: "module",
  },
  extends: [
    "plugin:vue/vue3-essential",
    "eslint:recommended",
  ],
  rules: {
    'vue/multi-word-component-names': 'off'
  }
}