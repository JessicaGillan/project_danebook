class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  
  def generate_token
    begin
      auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: auth_token)
  end

  def regenerate_token
    auth_token = nil
    generate_token
    save!
  end
end
