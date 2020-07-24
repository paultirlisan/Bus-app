require 'will_paginate/array'
require 'will_paginate'
require 'will_paginate/active_record'

class StaticPagesController < ApplicationController
	before_action :authenticate_user!, only: :history

	def home
		@date = DateTime.now
		if params[:commit] == "Search"
			if !initialize_search_params
				render 'home'
				return
			end

			@routes = Route.search_routes_by_params(@departure_city, @arrival_city, @date,
							@company, @price_range)
			@routes = @routes.paginate(page: params[:page], per_page: 10)
		end
	end

	def history
		@journeys = current_user.journeys.group_by { |j| [j.user_id, j.route_id, j.date] }.
						map {|identifier, vector| [vector.first, vector.length]}

	end
end
