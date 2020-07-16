module ApplicationHelper
	def signed_in_company
		redirect_to root_path if !user_signed_in? || !current_user.has_company?
	end
end
