FactoryBot.define do
  
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { "password" }
  end

  factory :user2, class: User do
    name { "hoge" }
    email { "hoge@hoge.hoge" }
    password { "hogehoge"}
  end
end
