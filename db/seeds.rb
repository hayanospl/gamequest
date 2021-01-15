# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: 'test',
  email: 'test@test.test',
  password: 'testtest',
  profile: 'testtestest'
)

10.times do |n|
  name = Faker::Name.name
  email = "dummy#{n+1}@gamequest.com"
  password = "password"
  profile = Faker::Lorem.sentence(word_count: 5)
  User.create!(name:      name,
               email:     email,
               password:  password,
               profile: profile)
end

users = User.order(:created_at).take(5)

10.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 3)
  users.each { |user| user.posts.create!(title: title, content: content) }
end

posts = Post.all
posts.each do |post|
  post.tag_list.add("test", "game")
  post.save
end
  # フォローフォロワー関係
users = User.all
user  = users.first
following = users[2..10]
followers = users[3..7]
following.each { |followed| user.follow(followed)}
followers.each { |follower| follower.follow(user)}

#コメント、いいね、画像、
Like.create(post_id: 50, user_id: 2)
Comment.create(post_id: 50, user_id: 3, content: "testtesttest")

Post.create(
  user_id: 1,
  title: 'image-test',
  content: 'image-test',
  image: File.open("./app/assets/images/default.jpg")
)

Comment.create(post_id: 51, 
                user_id: 4, 
                content: "testtesttesttest",
                image: File.open("./app/assets/images/default.jpg"))
