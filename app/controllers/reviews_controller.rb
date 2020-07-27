class ReviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:destroy]

	def create
		@review = current_user.reviews.build(review_params)
		@company = Company.find_by_id(params[:review][:company_id])
		if @review.save
			flash[:success] = "The review has been successfully created"
			redirect_to company_path(@company)
		else
			render 'companies/show'
		end
	end

	def destroy
		if @review.destroy
			flash[:success] = "The review has been deleted."
		end
		redirect_to company_path(@review.company)
	end

	private
	def review_params
		params.require(:review).permit(:company_id, :rating, :body)
	end

	def correct_user
		@review = Company.find_by_id(params[:id]).reviews.find_by_id(params[:company_id])	# weird
		redirect_to root_path if @review.nil? || @review.user != current_user
	end
end