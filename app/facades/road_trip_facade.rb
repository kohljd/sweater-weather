class RoadTripFacade
  def self.trip_details_for(origin, destination)
    route_data = RoadTripService.travel_time_and_coordinates(origin, destination)
    coordinates = route_data[:locations].last[:latLng]
    eta = format_time(route_data)
    weather = RoadTripService.weather_at_arrival(coordinates, eta)
    RoadTrip.new(origin, destination, route_data, weather)
  end

  def self.format_time(route_data)
    arrival_time = Time.now + route_data[:time].last
    time = {}
    time[:date] = arrival_time.to_date.to_fs(:iso8601)
    time[:hour] = arrival_time.hour
    time[:hour] += 1 if arrival_time.min >= 30
    time
  end
end