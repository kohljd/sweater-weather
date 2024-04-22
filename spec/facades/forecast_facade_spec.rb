require "rails_helper"

RSpec.describe ForecastFacade do
  describe ".get_coordinates_for(location)" do
    it "returns location's coordinates" do
      json_response = File.read("spec/fixtures/denver_coordinates.json")
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address").
        with(
          query: {
              key: Rails.application.credentials.map_quest[:api_key],
              location: 'Denver, CO'
            }
          ).
        to_return(status: 200, body: json_response)

      coordinates = ForecastFacade.get_coordinates_for("Denver, CO")

      expect(coordinates).to be_a(Hash)
      expect(coordinates[:lat]).to eq(39.74001)
      expect(coordinates[:lng]).to eq(-104.99202)
    end
  end

  describe ".get_weather_for(location)" do
    it "returns location's weather" do
      coordinates = {lat: 39.74001, lng: -104.99202}
      json_response = File.read("spec/fixtures/denver_forecast_2024-04-21.json")
      stub_request(:get, "https://api.weatherapi.com/v1/forecast.json").
        with(
          query: {
              key: Rails.application.credentials.weather[:api_key],
              q: "#{coordinates[:lat]},#{coordinates[:lng]}",
              days: 5,
              aqi: "no",
              alerts: "no"
            }
          ).
        to_return(status: 200, body: json_response)

      forecast = ForecastFacade.get_weather_for(coordinates)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather).to all(be_a(Hash))
      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather).to all(be_a(Hash))
    end
  end
end