class Photo < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  # TODO fix this association, cover and profile
  has_one :profile_as_profile, foreign_key: :profile_photo_id,
                             class_name: "Profile"
  has_one :profile_as_cover, foreign_key: :cover_photo_id,
                               class_name: "Profile"

  has_attached_file :user_photo, styles: { :medium => "300x300", :thumb => "100x100" }

  has_many :likes,    :as => :likable,     dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  validates_attachment_content_type :user_photo, :content_type => /\Aimage\/.*\Z/
  validates :user_photo, presence: true
end
