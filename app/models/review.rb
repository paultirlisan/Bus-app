class IdentityValidator < ActiveModel::Validator
	def validate(record)
		if record.user == record.company.user
			record.errors[:base] << "You can't write a review to your own company"
		end
	end
end

class Review < ApplicationRecord
	belongs_to :user
	belongs_to :company

	validates :user_id, presence: true, uniqueness: { scope: :company_id }
	validates :company_id, presence: true
	validates :body, presence: true
	validates_with IdentityValidator

	def yellow_stars
		rating.to_i
	end

	def blank_stars
		5 - rating.to_i
	end
end
