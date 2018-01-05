class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_profile
  before_action :validate_edit_action, only: [:edit], if: :not_user_controller?

  def check_profile
  	if user_signed_in?
  		unless current_user.profile
  			redirect_to new_profile_path
        return false
  		end
  	end
  end

  def validate_edit_action
    @obj = controller_name.classify.constantize.find_by(id: params[:id])
    if current_user.id == @obj.user_id
      return true
    else
      flash[:alert] = "You don't have access to view this page."
      redirect_to home_index_path
    end
  end

  private

  def not_user_controller?    
    unless controller_name == "registrations"
      return true
    end
  end
end
