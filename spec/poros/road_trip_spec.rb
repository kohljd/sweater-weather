require "rails_helper"

RSpec.describe RoadTrip do
  it "creates RoadTrip object from parsed JSON data" do
    json_1 = File.read("spec/fixtures/road_trip/cincinnati_to_chicago.json")
    route_data = JSON.parse(json_1, symbolize_names: true)
    json_2 = File.read("spec/fixtures/road_trip/weather_on_arrival.json")
    weather = JSON.parse(json_2, symbolize_names: true)

    road_trip = RoadTrip.new("Cincinnati, OH", "Chicago, IL", route_data, weather)
    expect(road_trip).to be_a(RoadTrip)
    expect(road_trip.start_city).to eq("Cincinnati, OH")
    expect(road_trip.end_city).to eq("Chicago, IL")
    expect(road_trip.travel_time).to eq("4 hrs 20 min")
    expect(road_trip.weather_at_eta[:datetime]).to eq("2024-04-24 05:00")
    expect(road_trip.weather_at_eta[:temperature]).to eq(38.2)
    expect(road_trip.weather_at_eta[:condition]).to eq("Patchy rain nearby")
  end
end