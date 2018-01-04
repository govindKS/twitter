class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_profile

  def check_profile
  	if user_signed_in?
  		unless current_user.profile
  			redirect_to new_profile_path && return
  		end
  	end
  end
end
