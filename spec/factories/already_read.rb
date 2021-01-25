FactoryBot.define do
  factory :already_read do
    post
    user_id { create(:user2).id }
  end
end