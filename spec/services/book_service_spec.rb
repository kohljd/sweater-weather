require "rails_helper"

RSpec.describe BookService do
  describe ".get_books_about(location)" do
    it "returns search results for books about a given location" do
      json_response = File.read("spec/fixtures/book_search_results.json")
      stub_request(:get, "https://openlibrary.org/search.json").
        with( query: { q: 'denver,co' }).
        to_return(status: 200, body: json_response)

      parsed_json = BookService.get_books_about('denver,co')
      expect(parsed_json).to be_a(Hash)
      expect(parsed_json[:q]).to eq("denver,co")
      expect(parsed_json[:numFound]).to be_an(Integer)
      expect(parsed_json[:docs][0]).to include(:title, :publisher, :isbn)
      expect(parsed_json[:docs][0][:title]).to be_a(String)
      expect(parsed_json[:docs][0][:publisher]).to be_an(Array)
      expect(parsed_json[:docs][0][:isbn]).to be_an(Array)
    end
  end
end