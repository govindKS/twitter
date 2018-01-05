class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		@tweets = Tweet.all
	end

	def search_user		
		@users = User.joins(:profile).where("( users.email LIKE ? OR profiles.first_name LIKE ? ) AND users.id != ?", "%#{params[:search]}%", "%#{params[:search]}%", current_user.id)
		respond_to do |format|
			format.js
		end
	end

	def tweets
		@following_ids = current_user.followings.pluck(:following_user_id)
		@tweets = Tweet.where(user_id: @following_ids)
	end
end
