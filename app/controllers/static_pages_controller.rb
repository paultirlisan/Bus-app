class StaticPagesController < ApplicationController

	def home
		@show_for_now = nil
		if params[:commit] == "Search"
			render 'home' if !initialize_search_params
			@show_for_now = { departure_city: @departure_city, arrival_city: @arrival_city,
								date: @date, company: @company, price_range: @price_range }
		end
	end

	private
	def initialize_search_params
		if params[:departure_city].nil? || params[:departure_city].empty? || 
				params[:arrival_city].nil? || params[:arrival_city].empty? || 
				params[:date].nil? || params[:date].empty? || params[:company].nil? || 
				params[:price].nil?
			flash.now[:danger] = "You must complete the departure/arrival cities and the date."
			return false
		end
		if params[:departure_city] == params[:arrival_city]
			flash.now[:danger] = "You must choose different cities."
			return false
		end
		@departure_city = params[:departure_city]
		@arrival_city = params[:arrival_city]
		@date = Date.strptime(params[:date], "%m/%d/%Y")
		@company = params[:company]
		@price_range = params[:price]
		return true
	end
end
