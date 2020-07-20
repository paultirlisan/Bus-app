class RoutesController < ApplicationController
  def new
    @route = current_user.company.routes.build
  end

  def create
    departure_station = Station.find_by_company_name_city(current_user.company, 
                                  params[:route][:departure_station])
    arrival_station = Station.find_by_company_name_city(current_user.company,
                                  params[:route][:arrival_station])

    #departure_station = current_user.company.stations.first
    #arrival_station = current_user.company.stations.second

    start_date = DateTime.civil(params[:route]["start_date(1i)"].to_i, 
      params[:route]["start_date(2i)"].to_i,
      params[:route]["start_date(3i)"].to_i, params[:route]["start_date(4i)"].to_i,
      params[:route]["start_date(5i)"].to_i)
    end_date = DateTime.civil(params[:route]["end_date(1i)"].to_i, 
      params[:route]["end_date(2i)"].to_i,
      params[:route]["end_date(3i)"].to_i, params[:route]["end_date(4i)"].to_i,
      params[:route]["end_date(5i)"].to_i)
    @route = current_user.company.routes.build(departure_station_id: departure_station.id,
                                      arrival_station_id: arrival_station.id,
                                      name: params[:route][:name],
                                      duration: params[:route][:duration],
                                      distance: params[:route][:distance],
                                      start_date: start_date,
                                      end_date: end_date,
                                      period: params[:route][:period],
                                      price: params[:route][:price],
                                      capacity: params[:route][:capacity])
    if @route.save
      flash[:success] = "The route has been created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def route_params
    params.require(:route).permit(:name, :duration, :distance,
                            :period, :price, :capacity)
  end
end
