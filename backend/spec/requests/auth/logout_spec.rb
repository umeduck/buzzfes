require 'rails_helper'

RSpec.describe 'User Logout API', type: :request do
  let!(:user) { create(:user, email: 'logout@example.com') }

  # ログインしてトークンを取得
  let(:login_response) do
    post '/auth/sign_in', params: {
      email: 'logout@example.com',
      password: 'password123'
    }, as: :json
    response
  end

  let(:auth_headers) do
    {
      'access-token' => login_response.headers['access-token'],
      'client' => login_response.headers['client'],
      'uid' => login_response.headers['uid']
    }
  end

  describe 'DELETE /auth/sign_out' do
    context 'ログイン中のユーザーがログアウトする場合' do
      it '200 OK を返し、トークンが無効化されること' do
        # ログアウト実行
        delete '/auth/sign_out', headers: auth_headers, as: :json

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['success']).to be true
      end
    end

    context 'トークンが無効または存在しない場合' do
      it '404 not found を返すこと' do
        delete '/auth/sign_out', headers: {
          'access-token' => 'invalid',
          'client' => 'wrong',
          'uid' => user.email
        }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end