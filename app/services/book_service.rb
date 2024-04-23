class BookService
  def self.get_books_about(location)
    get_url("/search.json", q:location)
  end

  def self.get_url(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://openlibrary.org")
  end
end