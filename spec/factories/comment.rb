FactoryBot.define do
  factory :comment do
    post
    user {post.user}
    id { 1 }
    content { "testtesttest" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/default.jpg'))}
  end
end
