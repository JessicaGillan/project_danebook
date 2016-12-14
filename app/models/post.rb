class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :likes,    :as => :likable,     dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  validates :body, length: { minimum: 1 }
end
