class Profile < ApplicationRecord
  mount_uploader :profile_image, AttachmentUploader
  validates :first_name, :last_name, :about_me, :user_id, presence: true
  belongs_to :user
end
