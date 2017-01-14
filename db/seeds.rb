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

User.create( email: "gillan.jessica@gmail.com",
             password: PASSWORD,
             password_confirmation: PASSWORD )

N.times do
  User.create( email: Faker::Internet.email,
               password: PASSWORD,
               password_confirmation: PASSWORD )
end
users = User.all

puts "Creating Profiles and Posts for each user, adding friends"

users.each do |user|
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

  user.friended_users << users
end

puts "adding profile photos to users"

NUM_PROF_PHOTOS = 12
users.each_with_index do |user, i|
  user.photos.build(user_photo: File.open("app/assets/images/users/#{i%(NUM_PROF_PHOTOS)}.jpeg"))
  user.save
  user.profile.profile_photo = user.photos.first
  user.save
end

puts "Creating JG Profile"

me = User.create( email: "gillan.jessica@gmail.com",
             password: PASSWORD,
             password_confirmation: PASSWORD )

me.create_profile( first_name: "Jessica",
                   last_name:  "Gillan",
                   birthday:   Faker::Date.between(30.years.ago, 10.years.ago),
                   college:    "Colorado School of Mines",
                   hometown:   "Arvada",
                   current_location: "Denver, CO",
                   phone:     '',
                   tagline:   '"No computer is ever going to ask a new, reasonable question. It takes trained people to do that." - Grace Hopper',
                   about_me:  "Engineer, developer, coffee drinker, and dance party-er.",
                   gender:    1
                   )

N.times do
 me.posts.create( body: Faker::ChuckNorris.fact )
end

me.friended_users << users
me.photos.build(user_photo: File.open("app/assets/images/users/me.jpg"))
me.save
me.profile.profile_photo = user.photos.first
me.save

users = User.all

puts "Adding photos to user's collections"
NUM_PHOTOS = 14
users.each_with_index do |user, i|
  rand(N/2).times do |n|
    user.photos.build(user_photo: File.open("app/assets/images/photos/#{i%(NUM_PHOTOS) + n}.jpeg"))
  end

  user.save
end

puts "Creating comments and likes on posts"

user_ids = users.pluck(:id)
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
