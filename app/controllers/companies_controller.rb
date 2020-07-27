require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/array'

class CompaniesController < ApplicationController
	before_action :set_companies_controller_active

	def show
		@date = DateTime.now
		@review = Review.new
		@reviews = @company.reviews.order("id DESC").paginate(page: params[:page], per_page: 15)

		if params[:commit] == "Search"
			if !initialize_search_params
				render 'show'
				return
			end

			@routes = Route.search_routes_by_params(@departure_city, @arrival_city, @date,
							@company, @price_range)
			@routes = @routes.paginate(page: params[:page], per_page: 10)
		end
	end

	def careers
	end

	def contact
	end

	private
	def set_companies_controller_active
		@company = Company.find_by_id(params[:id])
		@companies_controller_active = true
	end
end