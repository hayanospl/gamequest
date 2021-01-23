FactoryBot.define do
  factory :like do
    id { 1 }
    association :post
    user { post.user }
  end
end
