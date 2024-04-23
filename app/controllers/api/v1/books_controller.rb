class Api::V1::BooksController < ApplicationController
  def index
    book_results = BookFacade.get_books_about(params[:location], params[:quantity])
    render json: BooksSerializer.new(book_results)
  end
end