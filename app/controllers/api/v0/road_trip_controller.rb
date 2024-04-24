class Api::V0::RoadTripController < ApplicationController
  def create
    # req user's api_key, 401
    user = User.find_by(api_key: params[:api_key])
    if user && (params[:origin] && params[:destination]).present?
      road_trip = RoadTripFacade.trip_details_for(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip), status: :created
    elsif params[:origin].blank? || params[:destination].blank?
      render json: { errors:[{ status: 400, detail: "Both origin and destination required" }] }, status: :bad_request
    else
      render json: { errors:[{ status: 401, detail: "Unauthorized access" }] }, status: :unauthorized
    end
  end
end
