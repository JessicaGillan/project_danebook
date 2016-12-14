FactoryGirl.define do
  factory :profile do
    college 'UW'
    hometown 'Cheyenne'
    current_location 'Arvada'
    phone '555-867-5309'
    about_me 'squirrel'
    tagline 'SQUIRREL'
    first_name 'Annie'
    last_name 'Buttons'
    birthday '2016-12-07'
    gender 0

    user
  end
end
