class Company < ApplicationRecord
	belongs_to :user

	validates :description, presence: true
	validates :phone, presence: true, length: { minimum: 10, maximum: 15 },
				numericality: true
	validates :headquarters, presence: true
	validates :careers_advertisement, presence: true
end
