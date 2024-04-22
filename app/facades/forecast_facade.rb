class ForecastFacade
  def self.get_coordinates_for(location)
    json = ForecastService.get_coordinates_for(location)
    coord = json[:results][0][:locations][0][:latLng]
  end

  def self.get_weather_for(coordinates)
    json = ForecastService.get_weather_for(coordinates)
    Forecast.new(json)
  end
end