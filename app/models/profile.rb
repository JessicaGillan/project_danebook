class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile, optional: true

  belongs_to :profile_photo, class_name: 'Photo', optional: true
  belongs_to :cover_photo,   class_name: 'Photo', optional: true

  validates :first_name, :last_name, presence: true

  enum gender_options: [:male, :female]
end
