FactoryBot.define do
  factory :commentlike, class: CommentLike do
    association :comment
    user { comment.user }
  end
end
