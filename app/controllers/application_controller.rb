class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_error

  def not_found_error(exception)
    render json: { errors:[{ status: 404, detail: exception.message }] }, status: :not_found
  end

  def invalid_error(exception)
    render json: { errors:[{ status: 400, detail: exception.message }] }, status: :bad_request
  end
end
