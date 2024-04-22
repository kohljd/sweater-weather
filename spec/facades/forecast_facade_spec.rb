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
end