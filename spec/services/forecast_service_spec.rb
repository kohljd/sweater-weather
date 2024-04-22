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
end