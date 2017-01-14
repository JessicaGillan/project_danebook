# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

N = 10
PASSWORD = '111111'

puts "Cleaning database"

if Rails.env == 'development'
  Rake::Task['db:migrate:reset'].invoke
end

puts "Creating Users"

N.times do
  User.create( email: Faker::Internet.email,
               password: PASSWORD,
               password_confirmation: PASSWORD )
end

puts "Creating Profiles and Posts for each user, adding friends"

User.all.each do |user|
  user.create_profile( first_name: Faker::Name.first_name,
                      last_name:  Faker::Name.last_name,
                      birthday:   Faker::Date.between(30.years.ago, 10.years.ago),
                      college:    Faker::Educator.university,
                      hometown:   Faker::Space.star,
                      current_location: Faker::Book.title,
                      phone:     '303-867-5309',
                      tagline:   Faker::Hipster.sentence,
                      about_me:  Faker::Hipster.paragraph,
                      gender:    rand(1)
                      )

  N.times do
    user.posts.create( body: Faker::ChuckNorris.fact )
  end

  user.friended_users << User.all
end

puts "Creating comments and likes on posts"

user_ids = User.all.pluck(:id)
Post.all.each do |post|
  rand(N/2).times do
    post.comments.create( author_id: user_ids.sample,
                          body:      Faker::Beer.name )

    post.likes.create( liker_id: user_ids.sample )
  end
end

puts "Adding likes to comments"

Comment.all.each do |c|
  rand(N/3).times do
    c.likes.create( liker_id: user_ids.sample )
  end
end

puts "Done"
