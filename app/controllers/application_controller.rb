class ApplicationController < ActionController::Base
	include ApplicationHelper

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name])
	end

end
