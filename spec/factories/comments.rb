FactoryGirl.define do
  factory :comment do
    author_id 1
    commentable_type "MyString"
    commentable_id 1
    body "MyText"
  end
end
