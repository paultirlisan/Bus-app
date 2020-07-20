class Company < ApplicationRecord
	belongs_to :user
	has_many :stations, dependent: :destroy
	has_many :routes, dependent: :destroy

	validates :description, presence: true
	validates :phone, presence: true, length: { minimum: 10, maximum: 15 },
				numericality: true
	validates :headquarters, presence: true
	validates :careers_advertisement, presence: true
end
