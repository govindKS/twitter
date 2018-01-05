class Comment < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	belongs_to :tweet
	belongs_to :user
end
