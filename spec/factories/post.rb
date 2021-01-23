FactoryBot.define do
  factory :post do
    association :user
    id { 1 }
    title { "test" }
    content { "testtesttest" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg'))}
    tag_list { "test" }
  end
end
