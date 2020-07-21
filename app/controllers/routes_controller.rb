class RoutesController < ApplicationController
  before_action :signed_in_company
  before_action :correct_company, only: [:edit, :update, :destroy]

  def new
    @route = current_user.company.routes.build
  end

  def create
    @route = current_user.company.routes.build(route_params)
    if @route.save
      flash[:success] = "The route has been created"
      redirect_to new_route_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @route.update_attributes(route_params)
      flash[:success] = "The route has been successfully updated."
      redirect_to edit_route_path(@route)
    else
      render 'edit'
    end
  end

  def destroy
    if @route.delete
      flash.now[:info] = "The route has been deleted"
    end
    render 'new'
  end

  private

  def route_params
    departure_station = Station.find_by_company_name_city(current_user.company, 
                                  params[:route][:departure_station])
    arrival_station = Station.find_by_company_name_city(current_user.company,
                                  params[:route][:arrival_station])
    start_date = DateTime.civil(params[:route]["start_date(1i)"].to_i, 
      params[:route]["start_date(2i)"].to_i,
      params[:route]["start_date(3i)"].to_i, params[:route]["start_date(4i)"].to_i,
      params[:route]["start_date(5i)"].to_i)
    end_date = DateTime.civil(params[:route]["end_date(1i)"].to_i, 
      params[:route]["end_date(2i)"].to_i,
      params[:route]["end_date(3i)"].to_i, params[:route]["end_date(4i)"].to_i,
      params[:route]["end_date(5i)"].to_i)

    { departure_station_id: departure_station.id, arrival_station_id: arrival_station.id,
      name: params[:route][:name], duration: params[:route][:duration],
      distance: params[:route][:distance], start_date: start_date,
      end_date: end_date, period: params[:route][:period], 
      price: params[:route][:price], capacity: params[:route][:capacity] }
  end

  def correct_company
    @route = current_user.company.routes.find_by_id(params[:id])
    redirect_to root_path if @route.nil?
  end
end
