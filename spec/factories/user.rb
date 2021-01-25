FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@test.test" }
    password { "testtest"}
    
  end

  factory :user2, class: User do
    name { "hoge" }
    email { "hoge@hoge.hoge" }
    password { "hogehoge"}
  end
end
