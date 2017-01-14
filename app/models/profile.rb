class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile, optional: true

  belongs_to :profile_photo, class_name: 'Photo', optional: true
  belongs_to :cover_photo,   class_name: 'Photo', optional: true

  validates :first_name, :last_name, presence: true

  enum gender_options: [:male, :female]

  DEFAULT_COVER_PHOTO_URL   = 'large_missing3.jpg'
  DEFAULT_PROFILE_PHOTO_URL = 'thumb_missing.jpg'

  def profile_photo_url(size_sym = :thumb )
    if profile_photo
      profile_photo.user_photo.url(size_sym)
    else
      DEFAULT_PROFILE_PHOTO_URL
    end
  end

  def cover_photo_url( size_sym = :large )
    if cover_photo
      cover_photo.user_photo.url
    else
      DEFAULT_COVER_PHOTO_URL
    end
  end

  def self.search(query)
    if query
      where("first_name ILIKE ?", "#{query}%")
      .or(self.where("last_name ILIKE ?", "#{query}%"))
    else
      # If no search term provided, this returns
      # a relation so we can chain this
      where("")
    end
  end
end
