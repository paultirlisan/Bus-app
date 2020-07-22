class StationsValidator < ActiveModel::Validator
	def validate(record)
		if record.departure_station_id == record.arrival_station_id
			record.errors[:base] << "Departure and arrival stations must be distinct"
		end
	end
end

class DateTimeValidator < ActiveModel::Validator
	def validate(record)
		if record.start_date.nil? || record.end_date.nil? || 
				record.start_date >= record.end_date
			record.errors[:base] << "End date must be greater than start date"
		end
	end
end

class Route < ApplicationRecord
	enum period: [:Daily, :Weekly, :Monthly, :Yearly]

	belongs_to :departure_station, class_name: "Station"
	belongs_to :arrival_station, class_name: "Station"
	belongs_to :company

	validates :departure_station_id, presence: true
	validates :arrival_station_id, presence: true
	validates_with StationsValidator
	validates :name, uniqueness: { scope: [:departure_station_id, :arrival_station_id] }
	validates :name, presence: true, length: { maximum: 20 }
	validates :duration, presence: true, numericality: { only_integer: true,
													greater_than: 0 }
	validates :distance, presence: true, numericality: { greater_than: 0 }
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates_with DateTimeValidator
	validates :period, presence: true
	validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :capacity, presence: true, numericality: { only_integer: true,
													greater_than: 0 }

	def time_by_repetition(date)
		case period
			when "Daily"
				"Everyday #{date.strftime('%H:%M')}"
			when "Weekly"
				"Every #{date.strftime('%A %H:%M')}"
			when "Monthly"
				"Every #{date.day} of the month, #{date.strftime('%H:%M')}"
			when "Yearly"
				"Every #{date.strftime('%B %d of the year %H:%M')}"
		end
	end

	def time_by_date(date)
		date.strftime("%B %d, %Y %H:%M")
	end

	def is_available(date)
		if date.dup.change(hour: start_date.hour, min: start_date.min) < start_date || 
			date.dup.change(hour: start_date.hour, min: start_date.min) >= end_date
			return false
		end

		case period
			when "Daily"
				true
			when "Weekly" 
				date.strftime("%A") == start_date.strftime("%A")
			when "Monthly"
				date.day == start_date.day
			when "Yearly"
				date.strftime("%B %d") == start_date.strftime("%B %d")
		end
	end

	def self.find_by_stations_date(departure_station, arrival_station, date)
		if departure_station.company != arrival_station.company
			return []
		end
		if !departure_station.company.active
			return []
		end
		if departure_station.city == arrival_station.city
			return []
		end

		possible_routes = Route.where(departure_station_id: departure_station.id,
									  arrival_station_id: arrival_station.id)
		return possible_routes.filter do |route|
			route.is_available(date)
		end
	end
end
