module Api::V1
  class FavoritesController < ApplicationController
    before_action :require_login, only: [:destroy]
    def create
      user = User.new(user_params)
      if user.save
        session[:username] = user.username
        render json: { status: :ok, message: "User created successfully" }
      else
        render json: {
          status: :unprocessable_entity,
          message: "User failed to save",
          data: user.errors }
      end
    end

    def destroy
      current_user.destroy
      head :ok
    end

    private

    def user_params
      params.permit(:username)
    end
  end
end