class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
	before_action :is_teacher!

	def is_teacher!
		if current_user && !current_user.role.teacher?
			sign_out current_user
			flash[:alert] = "Unauthorized!"
			redirect_to new_user_session_path
		end
	end
end
