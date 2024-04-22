require "rails_helper"

RSpec.describe "GET /api/v0/forecast" do
  it "gives today's overall, today's hourly, and 5-day forecast for a given city" do
    json_response_1 = File.read("spec/fixtures/denver_coordinates.json")
    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address").
      with(
        query: {
            key: Rails.application.credentials.map_quest[:api_key],
            location: 'Denver, CO'
          }
        ).
      to_return(status: 200, body: json_response_1)

    coordinates = {lat: 39.74001, lng: -104.99202}
    json_response_2 = File.read("spec/fixtures/denver_forecast_2024-04-21.json")
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
      to_return(status: 200, body: json_response_2)

    params = {"location":"Denver, CO"}
    headers = {"Content_Type": "application/json", "Accept": "application/json"}

    get "/api/v0/forecast", params: params, headers: headers

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    forecast = parsed_response[:data]
    expect(forecast[:id]).to eq(nil)
    expect(forecast[:type]).to eq("forecast")
    expect(forecast[:attributes]).to include(:current_weather, :daily_weather, :hourly_weather)

    current_weather = forecast[:attributes][:current_weather]
    expect(current_weather).to include(:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon)

    daily_weather = forecast[:attributes][:daily_weather]
    expect(daily_weather).to be_an(Array)
    expect(daily_weather.size).to eq(5)
    expect(daily_weather).to all(include(:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon))

    hourly_weather = forecast[:attributes][:hourly_weather]
    expect(hourly_weather).to be_an(Array)
    expect(hourly_weather.size).to eq(24)
    expect(hourly_weather).to all(include(:time, :temperature, :conditions, :icon))
  end
end