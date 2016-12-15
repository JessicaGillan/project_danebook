FactoryGirl.define do
  factory :profile do
    college 'UW'
    hometown 'Cheyenne'
    current_location 'Arvada'
    phone '555-867-5309'
    about_me 'squirrel'
    tagline 'SQUIRREL'
    sequence(:first_name){ Faker::Name.first_name }
    last_name Faker::Name.last_name
    birthday '2016-12-07'
    gender 0

    user
  end
end
