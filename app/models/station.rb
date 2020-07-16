class Station < ApplicationRecord
	belongs_to :company

	validates :name, presence: true
	validates :city, presence: true
end
