module Api::V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])

      if user.nil?
        render json: {status: :unprocessable_entity, message: "Invalid username"}
      else
        session[:username] = user.username
        render json: {status: :ok, message: "Successfully logged in"}
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