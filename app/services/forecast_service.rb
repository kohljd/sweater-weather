class ForecastService
  def self.get_coordinates_for(location)
    get_map_quest_url("/geocoding/v1/address", location:location)
  end

  def self.get_map_quest_url(url, params)
    response = map_quest_conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.map_quest_conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"]=Rails.application.credentials.map_quest[:api_key]
    end
  end

  def self.get_weather_for(lat, lon)
    get_weather_url("")
  end

  def self.weather_conn
    Faraday.new(url: "http://api.weatherapi.com/v1") do |faraday|
      faraday.params["key"]=Rails.application.credentials.weather[:api_key]
    end
  end
end