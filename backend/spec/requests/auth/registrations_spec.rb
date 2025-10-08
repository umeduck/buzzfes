require 'rails_helper'

RSpec.describe 'User Registration API', type: :request do
  describe 'POST /auth' do
    it '有効なパラメータで登録できること' do
      post '/auth', params: {
        name: 'テスト太郎',
        email: 'test@example.com',
        password: 'password123',
        confirm_success_url: 'http://example.com'
      }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data']['email']).to eq('test@example.com')
    end

    it 'メールがないと登録できないこと' do
      post '/auth', params: {
        name: 'メールなしユーザー',
        password: 'password123',
        confirm_success_url: 'http://example.com'
      }

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']['full_messages']).to include("Emailを入力してください")
    end

    it '重複メールでは登録できないこと' do
      create(:user, email: 'test@example.com')

      post '/auth', params: {
        name: '別ユーザー',
        email: 'test@example.com',
        password: 'password123',
        confirm_success_url: 'http://example.com'
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'パスワードがないと登録ができないこと' do
      post '/auth', params: {
        name: '別ユーザー',
        email: 'test@example.com',
        confirm_success_url: 'http://example.com'
      }
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']['full_messages']).to include("Passwordを入力してください")
    end
  end
end