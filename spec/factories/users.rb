FactoryGirl.define do
  factory :user, aliases: [:author, :liker, :friended_users, :users_friended_by] do
    sequence(:email){ |n| "foo#{n}@bar.com" }
    password "foobar"
  end
end
