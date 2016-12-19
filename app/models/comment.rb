class Comment < ApplicationRecord
  belongs_to :commentable, :polymorphic => true
  belongs_to :author,      class_name: "User"

  has_many :likes, :as => :likable, dependent: :destroy

  validates :body, length: { minimum: 1 }

end
