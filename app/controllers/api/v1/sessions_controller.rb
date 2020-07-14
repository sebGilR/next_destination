module Api::V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])

      if user.nil?
        render json: { message: "Invalid credentials"}
      else
        session[:username] = user.username
        render json: {
          connected: true,
          username: user.username,
          admin: user.admin,
          favorites: user.favorites,
        }
      end
    end

    def connected
      if @current_user
        render json: {
          connected: true,
          username: user.username,
          admin: user.admin,
          favorites: user.favorites,
        }
      else
        render json: {connected: false }
      end
    end

    def destroy
      reset_session
      head :ok
    end

    def login_params
      params.permit(:username)
    end
  end
end