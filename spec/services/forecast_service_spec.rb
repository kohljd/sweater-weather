require "rails_helper"

RSpec.describe ForecastService do
  describe ".get_coordinates_for(location)" do
    it "returns location's data" do
      json_response = File.read("spec/fixtures/denver_coordinates.json")
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address").
        with(
          query: {
              key: Rails.application.credentials.map_quest[:api_key],
              location: 'Denver, CO'
            }
          ).
        to_return(status: 200, body: json_response)

      parsed_json = ForecastService.get_coordinates_for('Denver, CO')
      expect(parsed_json).to be_a(Hash)
      expect(parsed_json[:results]).to be_an(Array)

      result = parsed_json[:results].first
      expect(result[:locations]).to be_an(Array)

      location = result[:locations].first
      expect(location).to be_a(Hash)
      expect(location[:latLng]).to be_a(Hash)
      expect(location[:latLng]).to include(:lat, :lng)
    end
  end

  describe ".get_weather_for(location)" do
    it "returns location's weather data" do
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

      parsed_json = ForecastService.get_weather_for(coordinates)

      expect(parsed_json).to be_a(Hash)
      expect(parsed_json[:current]).to include(:last_updated, :temp_f, :condition, :humidity, :feelslike_f, :vis_miles, :uv)
      expect(parsed_json[:current][:condition]).to include(:text, :icon)
      expect(parsed_json[:current]).to_not include(:temp_c, :is_day, :wind_mph, :pressure_in, :precip_in, :feelslike_c, :gust_mph)
      expect(parsed_json[:forecast][:forecastday].size).to eq(5)

      one_day = parsed_json[:forecast][:forecastday][0]
      expect(one_day).to include(:date, :day, :astro, :hour)

      expect(one_day[:astro]).to include(:sunrise, :sunset)
      expect(one_day[:astro]).to_not include(:moonrise, :moonset, :moon_phase)

      expect(one_day[:day]).to include(:maxtemp_f, :mintemp_f, :condition)
      expect(one_day[:day][:condition]).to include(:text, :icon)
      expect(one_day[:day]).to_not include(:maxtemp_c, :mintemp_c, :avgtemp_f, :maxwind_mph, :totalprecip_in, :avgvis_miles, :avghumidity, :daily_will_it_rain, :daily_chance_of_snow, :uv)

      expect(one_day[:hour].size).to eq(24)
      expect(one_day[:hour][0]).to include(:time, :temp_f, :condition)
      expect(one_day[:hour][0][:condition]).to include(:text, :icon)
      expect(one_day[:hour][0]).to_not include(:temp_c, :wind_mph, :wind_dir, :pressure_in, :precip_in, :humidity, :feelslike_f, :windchill_f, :heatindex_f, :vis_miles, :uv, :air_quality)
    end
  end
end