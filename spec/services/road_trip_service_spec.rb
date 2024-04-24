require "rails_helper"

RSpec.describe RoadTripService do
  describe ".travel_time_and_coordinates(origin, destination)" do
    it "returns location's data" do
      json_response = File.read("spec/fixtures/road_trip/cincinnati_to_chicago.json")
      stub_request(:post, "https://www.mapquestapi.com/directions/v2/routematrix").
        with( query: { key: Rails.application.credentials.map_quest[:api_key] }).
        to_return(status: 200, body: json_response)

      route_data = RoadTripService.travel_time_and_coordinates("Cincinnati, OH", "Chicago, IL")

      expect(route_data).to be_a(Hash)
      expect(route_data[:time]).to be_an(Array)
      expect(route_data[:locations]).to be_an(Array)
      expect(route_data[:locations]).to all(include(:adminArea5, :adminArea3))
      expect(route_data[:locations][1][:latLng]).to include(:lat, :lng)
    end
  end

  describe ".weather_at_arrival(coordinates, date, hour)" do
    it "returns weather forecast at estimated arrival time" do
      coordinates = {lat: 41.88425, lng: -87.63245}
      time = {date: "2024-04-24", hour: 5}
      json_response = File.read("spec/fixtures/road_trip/weather_on_arrival.json")
      stub_request(:get, "https://api.weatherapi.com/v1/forecast.json").
        with(
          query: {
              key: Rails.application.credentials.weather[:api_key],
              q: "#{coordinates[:lat]},#{coordinates[:lng]}",
              days: 1,
              dt: time[:date],
              hour: time[:hour],
              aqi: "no",
              alerts: "no"
            }
          ).
        to_return(status: 200, body: json_response)

      parsed_json = RoadTripService.weather_at_arrival(coordinates, time)
      expect(parsed_json).to be_a(Hash)

      weather = parsed_json[:forecast][:forecastday]
      expect(weather.size).to eq(1)
      expect(weather[0][:hour].size).to eq(1)
      expect(weather[0][:hour][0]).to include(:time, :temp_f, :condition)
      expect(weather[0][:hour][0][:condition]).to include(:text)
    end
  end
end