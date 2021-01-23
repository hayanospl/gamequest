FactoryBot.define do
  factory :user do
    id { 1 } 
    name { "test" }
    email { "test@test.test" }
    password { "testtest"}
    
  end

  factory :user2, class: User do
    id { 2 }
    name { "hoge" }
    email { "hoge@hoge.hoge" }
    password { "hogehoge"}
  end
end
