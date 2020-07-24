class RouteValidator < ActiveModel::Validator
	# The case when the route belongs to the user whose id is user_id 
	# (a user can't buy a ticket for his own route)
	def validate(record)
		route = Route.find_by_id(record.route_id)
		if route.nil? || route.company.user.id == record.user_id
			record.error[:base] << "Route is not valid"
		end
	end
end

class Journey < ApplicationRecord
	belongs_to :user
	belongs_to :route

	validates :user_id, presence: true
	validates :route_id, presence: true
	validates_with RouteValidator
	validates :date, presence: true
end
