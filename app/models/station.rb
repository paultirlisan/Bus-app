class Station < ApplicationRecord
	belongs_to :company
	has_many :departure_routes, class_name: "Route", 
			foreign_key: :departure_station_id, dependent: :destroy
	has_many :arrival_routes, class_name: "Route",
			foreign_key: :arrival_station_id, dependent: :destroy

	validates :name, presence: true
	validates :city, presence: true
	validates :company_id, uniqueness: { scope: [:name, :city] }

	def self.find_by_company_name_city(company, name_and_city_string)
		company.stations.each do |station|
			if name_and_city_string == "#{station.name}, #{station.city}"
				return station
			end
		end
		return nil
	end

	def self.find_by_city(city)
		Station.where(city: city)
	end

	def self.find_by_city_company(city, company)
		Station.where(city: city, company_id: company.id)
	end
end
