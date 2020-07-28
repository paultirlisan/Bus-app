class Company < ApplicationRecord
	belongs_to :user
	has_many :stations, dependent: :destroy
	has_many :routes, dependent: :destroy
	has_many :reviews, dependent: :destroy

	validates :description, presence: true
	validates :phone, presence: true, length: { minimum: 10, maximum: 15 },
				numericality: true
	validates :headquarters, presence: true
	validates :careers_advertisement, presence: true

	def average_score
		number_of_reviews == 0 ? 0 : total_score / number_of_reviews
	end

	def total_score
		total_score = 0.0
		self.ratings_frequency.each do |rating_frequency|
			total_score += rating_frequency[0] * rating_frequency[1]
		end
		return total_score
	end

	def ratings_frequency
		reviews.map(&:rating).map {|rating| rating.to_i}.group_by {|rating| rating}.map do |stars, vector|
			[stars, vector.length]
		end
	end

	def number_of_reviews
		reviews.count
	end

	def reviews_with_rating(rating)
		reviews.where(rating: rating).count
	end

	def percent_reviews_with_rating(rating)
		number_of_reviews == 0 ? 0 : reviews_with_rating(rating) * 100 / number_of_reviews
	end
end
