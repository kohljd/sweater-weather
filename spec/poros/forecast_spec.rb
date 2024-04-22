require "rails_helper"

RSpec.describe Forecast do
  it "creates Forecast object from parsed JSON data" do
    json = File.read("spec/fixtures/denver_forecast_2024-04-21.json")
    data = JSON.parse(json, symbolize_names: true)

    forecast = Forecast.new(data)
    expect(forecast).to be_a(Forecast)

    expect(forecast.current_weather).to be_a(Hash)
    expect(forecast.current_weather[:last_updated]).to eq("2024-04-21 20:45")
    expect(forecast.current_weather[:temperature]).to eq(55.4)
    expect(forecast.current_weather[:feels_like]).to eq(52.6)
    expect(forecast.current_weather[:humidity]).to eq(41)
    expect(forecast.current_weather[:uvi]).to eq(1.0)
    expect(forecast.current_weather[:visibility]).to eq(9.0)
    expect(forecast.current_weather[:condition]).to eq("Partly cloudy")
    expect(forecast.current_weather[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/116.png")

    expect(forecast.daily_weather).to be_an(Array)
    expect(forecast.daily_weather.size).to eq(5)
    expect(forecast.daily_weather[2][:date]).to eq("2024-04-23")
    expect(forecast.daily_weather[2][:sunrise]).to eq("06:10 AM")
    expect(forecast.daily_weather[2][:sunset]).to eq("07:47 PM")
    expect(forecast.daily_weather[2][:max_temp]).to eq(65.0)
    expect(forecast.daily_weather[2][:min_temp]).to eq(48.1)
    expect(forecast.daily_weather[2][:condition]).to eq("Patchy rain nearby")
    expect(forecast.daily_weather[2][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/176.png")

    expect(forecast.hourly_weather).to be_an(Array)
    expect(forecast.hourly_weather.size).to eq(24)
    expect(forecast.hourly_weather[2][:time]).to eq("02:00")
    expect(forecast.hourly_weather[2][:temperature]).to eq(33.3)
    expect(forecast.hourly_weather[2][:conditions]).to eq("Partly Cloudy ")
    expect(forecast.hourly_weather[2][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/116.png")
  end
end