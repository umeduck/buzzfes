require 'rails_helper'

RSpec.describe 'User Login API', type: :request do
  let!(:user) do
    create(:user, email: 'login@example.com')
  end

  describe 'POST /auth/sign_in' do
    it '正しい認証情報でログインできること' do
      post '/auth/sign_in', params: {
        email: 'login@example.com',
        password: 'password123'
      },
      as: :json

      expect(response).to have_http_status(:ok)

      # トークンヘッダーが返る
      expect(response.headers['access-token']).to be_present
      expect(response.headers['client']).to be_present
      expect(response.headers['uid']).to eq('login@example.com')
    end

    it 'トークンヘッダーが正しい形式で返ること' do
      post '/auth/sign_in',
          params: { email: 'login@example.com', password: 'password123' },
          as: :json

      token = response.headers['access-token']
      client = response.headers['client']
      uid = response.headers['uid']

      expect(token).to be_present
      expect(client).to be_present
      expect(uid).to eq('login@example.com')
    end

    it '存在しないemailではログインができないこと' do
      post '/auth/sign_in', params: {
        email: 'login@wrong.com',
        password: 'password123'
      },
      as: :json

      expect(response).to have_http_status(:unauthorized)
    end

    it '誤ったパスワードではログインできないこと' do
      post '/auth/sign_in', params: {
        email: 'login@example.com',
        password: 'wrongpassword'
      },
      as: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end
end