Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:8080', 'https://本番フロントのドメイン'
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: ['access-token', 'client', 'uid'] # devise_token_auth を使ってるなら
  end
end