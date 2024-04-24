class Api::V0::RoadTripController < ApplicationController
  def create
    # req user's api_key, 401
    road_trip = RoadTripFacade.trip_details_for(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(road_trip)
  end
end
