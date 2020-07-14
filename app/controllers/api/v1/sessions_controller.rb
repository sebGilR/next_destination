module Api::V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])

      if user.nil?
        render json: { message: "Invalid username / password"}
      else
        session[:username] = user.username
        render json: {
          username: user.username,
          admin: user.admin,
          favorites: user.favorites,
        }
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