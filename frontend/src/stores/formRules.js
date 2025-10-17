export const rules = {
  required: v => !!v || '必須項目です',
  email: v => /.+@.+\..+/.test(v) || 'メール形式で入力してください',
  min: l => v => (v && v.length >= l) || `${l}文字以上で入力してください`
}