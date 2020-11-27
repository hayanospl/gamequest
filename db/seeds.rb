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
  password: 'testtest'
)

10.times do |n|
  name = Faker::Name.name
  email = "dummy#{n+1}@gamequest.com"
  password = "password"
  User.create!(name:      name,
               email:     email,
               password:  password)
end

users = User.order(:created_at).take(5)
10.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 3)
  users.each { |user| user.posts.create!(title: title, content: content) }
end