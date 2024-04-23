class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by!(email: params[:email])
    if user&.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: :created
    else
      render json: { errors:[{ status: 422, detail: "Invalid credentials" }] }, status: :unprocessable_entity
    end
  end
end