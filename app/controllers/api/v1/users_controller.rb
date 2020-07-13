module Api::V1
  class FavoritesController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        render json: { status: :ok, message: "User created successfully" }
      else
        render json: {
          status: :unprocessable_entity,
          message: "User failed to save",
          data: user.errors }
      end
    end

    def destroy
      user = User.find_by(username: params[:username])
      user.destroy
      head :ok
    end

    private

    def user_params
      params.permit(:username)
    end
  end
end