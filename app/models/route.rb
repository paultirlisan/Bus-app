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
end
