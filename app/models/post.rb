class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, :as => :likable, dependent: :destroy
end
