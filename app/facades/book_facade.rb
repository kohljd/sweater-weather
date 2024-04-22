class BookFacade
  def self.get_books_about(location, quantity)
    json = BookService.get_books_about(location)
    coord = ForecastFacade.get_coordinates_for(location)
    forecast = ForecastFacade.get_weather_for(coord)
    current_weather = {condition: forecast.current_weather[:condition], temp: forecast.current_weather[:temperature]}
    Book.new(json, current_weather, quantity)
  end
end