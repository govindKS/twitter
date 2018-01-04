class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
	end

	def search_user
		@users = User.where("email LIKE ? AND id != ?", "%#{params[:search]}%", current_user.id)
		respond_to do |format|
			format.js
		end
	end
end
