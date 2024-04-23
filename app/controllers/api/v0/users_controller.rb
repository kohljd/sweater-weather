class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(new_user_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      require 'pry'; binding.pry
      # needs formatting
      render json: user.errors
    end
  end

  private

  def new_user_params
    params.permit(:email, :password, :password_confirmation)
  end
end