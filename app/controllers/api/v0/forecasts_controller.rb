class Api::V0::ForecastsController < ApplicationController
  def show
    coordinates = ForecastFacade.get_coordinates_for(params[:location])
    forecast = ForecastFacade.get_weather_for(coordinates)
    render json: ForecastSerializer.new(forecast)
  end
end