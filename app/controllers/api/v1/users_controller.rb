module Api::V1
  class UsersController < ApplicationController
    before_action :require_login, only: [:destroy]
    def create
      user = User.new(user_params)
      if user.save
        session[:username] = user.username
        render json: {
          connected: true,
          username: user.username,
          admin: user.admin,
          favorites: user.favorites,
        }
      else
        render json: { user: user.errors }
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