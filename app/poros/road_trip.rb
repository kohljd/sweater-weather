class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, route_data, weather)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = format_time(route_data[:time].last)
    @weather_at_eta = weather_at_destination(weather)
  end

  def format_time(time)
    t = time.to_i
    return "impossible route" if t == 0
      hours = t / 3600
      min = ( t % 3600 ) / 60
      "#{hours} hrs #{min} min"
  end

  def weather_at_destination(weather)
    return nil if @travel_time == "impossible route"
    eta_weather = {}
    eta_weather[:datetime] = weather[:forecast][:forecastday][0][:hour][0][:time]
    eta_weather[:temperature] = weather[:forecast][:forecastday][0][:hour][0][:temp_f]
    eta_weather[:condition] = weather[:forecast][:forecastday][0][:hour][0][:condition][:text]
    eta_weather
  end
end