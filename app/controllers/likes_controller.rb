class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :load_like
	
	def like
		@like.update(:is_like => true)
		render :json => true
	end

	def dislike
		@like.update(:is_like => false)
		render :json => true
	end

	private

	def load_like
		@like = Like.find_or_create_by(tweet_id: params[:tweet_id], user_id: current_user.id)
	end
end
