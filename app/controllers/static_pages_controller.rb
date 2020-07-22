require 'will_paginate/array'

class StaticPagesController < ApplicationController

	def home
		@date = DateTime.now
		if params[:commit] == "Search"
			if !initialize_search_params
				render 'home'
				return
			end

			if @company.nil?
				@departure_stations = Station.find_by_city(@departure_city)
				@arrival_stations = Station.find_by_city(@arrival_city)
			else
				@departure_stations = Station.find_by_city_company(@departure_city, @company)
				@arrival_stations = Station.find_by_city_company(@arrival_city, @company)
			end

			@routes = []
			@departure_stations.each do |departure_station|
				@arrival_stations.each do |arrival_station|
					# Filter by date
					possible_routes = Route.find_by_stations_date(departure_station, 
												arrival_station, @date)
					# Filter by price
					possible_routes.filter! { |route| @price_range.include?(route.price) }
					@routes = @routes + possible_routes
				end
			end
			@routes = @routes.paginate(page: params[:page], per_page: 10)
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
		@date = DateTime.strptime(params[:date], "%m/%d/%Y").change(hour: 0, min: 0)

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
