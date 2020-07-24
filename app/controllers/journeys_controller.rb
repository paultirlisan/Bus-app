class JourneysController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: :destroy

	def create
		@journey = current_user.journeys.build(journey_params)
		if Route.find_by_id(@journey.route_id).number_of_available_places(@journey.date) > 0 && @journey.save
			flash[:success] = "You have successfully bought a ticket."
		else
			flash[:danger] = "The ticket couldn't be bought."
		end

		redirect_back(fallback_location: root_path)
	end

	def destroy
		if Journey.where(user_id: @journey.user_id, route_id: @journey.route_id, 
							date: @journey.date).delete_all
			flash[:success] = "The journies have been successfully deleted."
			redirect_to history_path
		else
			render 'history'
		end
	end

	private
	def journey_params
		params.require(:journey).permit(:route_id, :date)
	end

	def correct_user
		@journey = Journey.find_by_id(params[:id])
		redirect_to root_path if @journey.nil? || @journey.user != current_user
	end
end