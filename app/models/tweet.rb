class Tweet < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	validates :message, :user_id, presence: true
  belongs_to :user
  has_many :likes
end
