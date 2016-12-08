class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

  validates :password, length: { minimum: 6 },
                       presence: true,
                       allow_nil: true

  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX },
                    presence: true

  before_create :generate_token
  before_save   :downcase_email

  has_one :profile, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :profile
  
  has_secure_password



  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end

  def downcase_email
    self.email = email.downcase
  end
end
