require "rails_helper"

RSpec.describe RoadTripFacade do
  describe ".trip_details_for(origin, destination)" do
    it "returns travel time and weather eta between two cities" do
      json_response_1 = File.read("spec/fixtures/road_trip/cincinnati_to_chicago.json")
      stub_request(:post, "https://www.mapquestapi.com/directions/v2/routematrix").
        with( query: { key: Rails.application.credentials.map_quest[:api_key] }).
        to_return(status: 200, body: json_response_1)

      allow(Time).to receive(:now).and_return(Time.parse("2024-04-24 02:22:40.541249 -0500"))
      coordinates = {lat: 41.88425, lng: -87.63245}
      date = "2024-04-24"
      hour = 7
      json_response_2 = File.read("spec/fixtures/road_trip/weather_on_arrival.json")
      stub_request(:get, "https://api.weatherapi.com/v1/forecast.json").
        with(
          query: {
              key: Rails.application.credentials.weather[:api_key],
              q: "#{coordinates[:lat]},#{coordinates[:lng]}",
              days: 1,
              dt: date,
              hour: hour,
              aqi: "no",
              alerts: "no"
            }
          ).
        to_return(status: 200, body: json_response_2)

      road_trip = RoadTripFacade.trip_details_for("Cincinnati, OH", "Chicago, IL")

      expect(road_trip).to be_a(RoadTrip)
    end
  end
end