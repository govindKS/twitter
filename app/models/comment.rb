class Comment < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	# belongs_to :tweet
	# belongs_to :user
	belongs_to :commentable, :polymorphic => true
	has_many :comments, :as => :commentable
end
