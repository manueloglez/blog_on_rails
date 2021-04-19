# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = "123"

Comment.delete_all
Post.delete_all
User.delete_all

me = User.create(
  name: "Manuel",
  email: "mang.95@gmail.com",
  password: PASSWORD
)

8.times do
  User.create(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: PASSWORD,
  )
end

users = User.all

50.times do 
  post = Post.create(
    title: Faker::Superhero.name,
    body: Faker::Lorem.paragraph_by_chars(number: rand(50..100)),
    user: users.sample,
  )
  if post.valid?
    post.comments = rand(1..15).times.map do
      Comment.new(
        body: Faker::GreekPhilosophers.quote,
        user: users.sample,
      )
    end
  end
end