FactoryBot.define do
  factory :commentlike, class: CommentLike do
    id { 1 }
    association :comment
    user { comment.user }
  end
end
