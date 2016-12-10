class Friending < ApplicationRecord
  belongs_to :friend_initiator, foreign_key: :friender_id,
                                class_name: "User"
  belongs_to :friend_recipient, foreign_key: :friended_id,
                                class_name: "User"

  # Make sure we validate the uniqueness of our records
  # to avoid duplicate friendings.  This reflects the
  # SQL uniqueness constraint we already migrated
  validates :friended_id, :uniqueness => { :scope => :friender_id }
end
