FactoryBot.define do
  factory :post do
    theme { nil }
    user { nil }
    content { "MyText" }
  end
end
