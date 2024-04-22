require "rails_helper"

RSpec.describe "GET /api/v1/book-search" do
  it "gives today's overall, today's hourly, and 5-day forecast for a given city" do
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

    params = {"location":"Denver, CO", "quantity":5}
    headers = {"Content_Type": "application/json", "Accept": "application/json"}

    get "/api/v1/book-search", params: params, headers: headers

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    books = parsed_response[:data]

    expect(books[:id]).to eq(nil)
    expect(books[:type]).to eq("books")
    expect(books[:attributes]).to include(:destination, :forecast, :total_books_found, :books)
    expect(books[:attributes][:destination]).to eq("Denver, CO")
    expect(books[:attributes][:total_books_found]).to be_an(Integer)

    book_list = books[:attributes][:books]
    expect(book_list).to be_an(Array)
    expect(book_list.size).to eq(5)
    expect(book_list).to all(be_a(Hash))
    expect(book_list).to all(include(:isbn, :title, :publisher))
    expect(book_list[0][:isbn]).to be_an(Array)
    expect(book_list[0][:publisher]).to be_an(Array)

    forecast = books[:attributes][:forecast]
    expect(forecast).to be_a(Hash)
    expect(forecast).to include(:summary, :temperature)
  end
end