class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile, optional: true

  validates :first_name, :last_name, presence: true

  enum gender_options: [:male, :female]

end
