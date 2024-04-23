class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(new_user_params)
    if user.save!
      render json: UsersSerializer.new(user), status: :created
    end
  end

  private

  def new_user_params
    params.permit(:email, :password, :password_confirmation)
  end
end