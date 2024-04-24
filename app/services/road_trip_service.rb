class RoadTripService
  def self.travel_time_and_coordinates(origin, destination)
    post_map_quest_url("/directions/v2/routematrix", {locations: [origin, destination]}.to_json )
  end

  def self.post_map_quest_url(url, body)
    response = map_quest_conn.post(url, body)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.map_quest_conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"]=Rails.application.credentials.map_quest[:api_key]
    end
  end

  def self.weather_at_arrival(coordinates, date, hour)
    params = {
      q: "#{coordinates[:lat]},#{coordinates[:lng]}",
      days: 1,
      dt: "#{date}",
      hour: "#{hour}",
      aqi: "no",
      alerts: "no"
    }
    get_weather_url("/v1/forecast.json", params)
  end

  def self.get_weather_url(url, params)
    response = weather_conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.weather_conn
    Faraday.new(url: "https://api.weatherapi.com") do |faraday|
      faraday.params["key"]=Rails.application.credentials.weather[:api_key]
    end
  end
end