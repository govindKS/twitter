module FollowingHelper
	def is_following(following_id)
		@follow = Following.find_by(user_id: current_user.id, following_user_id: following_id)
		if @follow.nil? or !@follow.is_following
			return true
		else
			return false
		end
	end
end
