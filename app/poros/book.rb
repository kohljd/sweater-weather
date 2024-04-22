class Book
  attr_reader :id,
              :destination,
              :forecast,
              :total_books_found,
              :books

  def initialize(book_results, current_weather, quantity)
    @id = nil
    @destination = book_results[:q]
    @forecast = format_weather(current_weather)
    @total_books_found = book_results[:numFound]
    @books = limit_results(book_results, quantity)
  end

  def format_weather(current_weather)
    weather = {}
    weather[:summary] = current_weather[:condition]
    weather[:temperature] = "#{current_weather[:temp].to_i} F"
    weather
  end

  def limit_results(book_results, quantity)
    books = []
    results = book_results[:docs].take(quantity.to_i)
    
    results.each do |book_result|
      book = {}
      book[:isbn] = book_result[:isbn]
      book[:title] = book_result[:title]
      book[:publisher] = book_result[:publisher]
      books << book
    end
    books
  end
end