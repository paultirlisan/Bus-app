class StationsController < ApplicationController
	before_action :signed_in_company

	def new
		@station = current_user.company.stations.build
	end

	def create
		@station = current_user.company.stations.build(station_params)
		if @station.save
			flash[:success] = "The station has been successfully created."
			redirect_to new_station_path
		else
			render 'new'
		end
	end

	def edit
		@station = current_user.company.stations.find_by_id(params[:id])
	end

	def update
		@station = current_user.company.stations.find_by_id(params[:id])
		if @station.update_attributes(station_params)
			flash[:success] = "The station has been successfully updated."
			redirect_to edit_station_path(@station)
		else
			render 'edit'
		end
	end

	def destroy
		@station = Station.find_by_id(params[:id])
		@station.destroy
		render 'new'
	end

private
	def station_params
		params.require(:station).permit(:name, :city)
	end
end
