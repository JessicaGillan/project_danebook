class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

  has_one :profile, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :profile

  has_many :posts,    foreign_key: :author_id, dependent: :destroy
  has_many :likes,    foreign_key: :liker_id,  dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :photos,   foreign_key: :owner_id, dependent: :destroy

  has_many :initiated_friendings, foreign_key: :friender_id,
                                  class_name: "Friending"
  has_many :friended_users,       through: :initiated_friendings,
                                  source:  :friend_recipient

  has_many :received_friendings, foreign_key: :friended_id,
                                 class_name:  "Friending"
  has_many :users_friended_by,   through: :received_friendings,
                                 source:  :friend_initiator

  has_secure_password

  validates :password, length: { minimum: 6 },
                       presence: true,
                       allow_nil: true

  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX },
                    presence: true

  before_create :generate_token
  after_create  :queue_welcome_email

  before_save   :downcase_email

  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end

  def downcase_email
    self.email = email.downcase
  end

  def first_name
    profile.first_name
  end

  def name
    "#{profile.first_name} #{profile.last_name}"
  end

  def random_friends( n = 6 )
    # rand_friends = []
    # count = friends.count
    #
    # if count <= 6
    #   friends
    # else
    #   n.times do
    #     begin
    #       friend = friends.sample
    #     end while rand_friends.include? friend
    #
    #     rand_friends << friend
    #   end
    #
    #   rand_friends
    # end
    random_selection(friends, n)
  end

  def random_photos( n = 6 )
    random_selection(photos, n)
  end

  def random_selection(association, n = 6 )
    rand_selection = []
    count = association.count

    if count <= 6
      association
    else
      n.times do
        begin
          selection = association.sample
        end while rand_selection.include? selection

        rand_selection << selection
      end

      rand_selection
    end
  end

  def friends
    friended_users + users_friended_by
  end

  private

  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def queue_welcome_email
    UserMailer.delay.welcome( self.id )
  end
end
