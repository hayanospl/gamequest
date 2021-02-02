FactoryBot.define do
  factory :post do
    user
    title { Faker::Lorem.sentence(word_count: 2) }
    content { Faker::Lorem.sentence(word_count: 3) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg'))}
    tag_list { Faker::Lorem.sentence(word_count: 1) }
  end

  factory :post2, class: Post do
    user_id { user2.id }
    title { Faker::Lorem.sentence(word_count: 2) }
    content { Faker::Lorem.sentence(word_count: 3) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg'))}
    tag_list { Faker::Lorem.sentence(word_count: 1) }
  end
end
