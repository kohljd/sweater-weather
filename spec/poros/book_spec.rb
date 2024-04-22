require "rails_helper"

RSpec.describe "Book" do
  it "creates Book object from parsed JSON data" do
    current_weather = {:condition=>"Partly cloudy", :temp=>55.4}
    quantity = 5
    json = File.read("spec/fixtures/book_search_results.json")
    data = JSON.parse(json, symbolize_names: true)

    books = Book.new(data, current_weather, quantity)

    expect(books).to be_a(Book)
    expect(books.id).to eq(nil)
    expect(books.destination).to eq("Denver, CO")
    expect(books.total_books_found).to eq(781)
    expect(books.forecast).to eq({:summary=>"Partly cloudy", :temperature=>"55 F"})
    expect(books.books.size).to eq(5)
    expect(books.books.last).to eq({:isbn=>["9781427401687", "1427401683"], :title=>"University of Denver Co 2007", :publisher=>["College Prowler"]})
  end
end