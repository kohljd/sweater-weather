class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_error

  def not_found_error(exception)
    if exception.message.include?("WHERE")
      render json: { errors:[{ status: 404, detail: "Couldn't find #{exception.model}" }] }, status: :not_found
    else
      render json: { errors:[{ status: 404, detail: exception.message }] }, status: :not_found
    end
  end

  def invalid_error(exception)
    if exception.message.include?("taken")
      render json: { errors:[{ status: 422, detail: exception.message }] }, status: :unprocessable_entity
    else
      render json: { errors:[{ status: 400, detail: exception.message }] }, status: :bad_request
    end
  end
end
