module ApplicationHelper
	def signed_in_company
		redirect_to root_path if !user_signed_in? || !current_user.has_company?
	end

	def initialize_search_params
		if params[:date].nil? || params[:date].empty?
			flash.now[:danger] = "You must complete the date"
			return false
		end

		@date = DateTime.strptime(params[:date], "%m/%d/%Y").change(hour: 0, min: 0)
		
		if params[:departure_city].nil? || params[:departure_city].empty? || 
				params[:arrival_city].nil? || params[:arrival_city].empty? || 
				params[:company].nil? || params[:price].nil?
			flash.now[:danger] = "You must complete the departure/arrival cities."
			return false
		end

		if params[:departure_city] == params[:arrival_city]
			flash.now[:danger] = "You must choose different cities."
			return false
		end

		@departure_city = params[:departure_city]
		@arrival_city = params[:arrival_city]

		if params[:company].empty?
			@company = nil
		else
			company_admin = User.find_by_name(params[:company])
			if company_admin.nil? || !company_admin.has_company?
				return false
			end
			@company = company_admin.company
		end

		@price_range = case params[:price]
			when ""
				(0..)
			when "0 - 10"
				(0..10)
			when "11 - 20"
				(11..20)
			when "21 - 50"
				(21..50)
			when "51 - 100"
				(51..100)
			when "Over 100"
				(100..)
		end

		return true
	end
end
