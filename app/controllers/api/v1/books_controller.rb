class Api::V1::BooksController < ApplicationController
  def index
    coordinates = ForecastFacade.get_coordinates_for(params[:location])
    forecast = ForecastFacade.get_forecast_for(coordinates)

    book_results = BookFacade.get_book_results(params[:location])
    combined_result = BookFacade.combine_books_and_forecast(forecast, book_results, params[:quantity])

    render json: ForecastSerializer.new(combined_result)
  end
end