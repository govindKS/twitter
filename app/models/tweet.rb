class Tweet < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	validates :message, :user_id, presence: true
  belongs_to :user
  has_many :likes
  has_many :comments, :as => :commentable
  scope :get_retweet, ->(tweet_id) { where("current_tweet_id = ? and is_retweet = ?", tweet_id, true )}
end
