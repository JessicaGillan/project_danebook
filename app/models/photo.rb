class Photo < ApplicationRecord
  include Commentable

  belongs_to :owner, class_name: 'User'

  has_one :profile_as_profile, foreign_key: :profile_photo_id,
                               class_name: "Profile"
  has_one :profile_as_cover,   foreign_key: :cover_photo_id,
                               class_name: "Profile"

  has_attached_file :user_photo, styles: {  thumb: "100x100#",
                                            small: "150x150",
                                            medium: "300x300",
                                          },
                    default_url: ":style_missing.jpg"

  has_many :likes,    :as => :likable,     dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  validates_attachment_content_type :user_photo, :content_type => /\Aimage\/.*\Z/
  validates :user_photo, presence: true
  # u.photos.build(user_photo: File.open('app/assets/images/photos/1.jpeg'))
  def user
    owner
  end
end
