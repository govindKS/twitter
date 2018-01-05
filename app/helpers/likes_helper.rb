module LikesHelper

	def is_liked(tweet)
		@like = Like.find_by(user_id: current_user.id, tweet_id: tweet)
		if @like.nil? or !@like.is_like
			return true
		else
			return false
		end
	end

end
