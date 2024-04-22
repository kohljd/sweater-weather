require "rails_helper"

RSpec.describe BookFacade do
  describe ".get_books_about(location, quantity)" do
    it "returns lists up to desired quantity of books and current weather for a given location" do
      json_response = File.read("spec/fixtures/book_search_results.json")
      stub_request(:get, "https://openlibrary.org/search.json").
        with( query: { q: "Denver, CO" }).
        to_return(status: 200, body: json_response)

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

      results = BookFacade.get_books_about("Denver, CO", 5)
require 'pry'; binding.pry
      results.each do |result|
        expect(result).to be_a(BookResult)
        # expect(results.current_weather).to be_a(Hash)
        # expect(results.daily_weather).to be_an(Array)
        # expect(results.daily_weather).to all(be_a(Hash))
        # expect(results.hourly_weather).to be_an(Array)
        # expect(results.hourly_weather).to all(be_a(Hash))
      end
    end
  end
end