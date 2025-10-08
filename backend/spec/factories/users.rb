FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    role { 0 }
    uid { SecureRandom.uuid }
    provider { 'email' }
    confirmed_at { Time.current }
  end
end