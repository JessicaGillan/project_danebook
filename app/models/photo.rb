class Photo < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_attached_file :photo, styles: { :medium => "300x300", :thumb => "100x100" }

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
