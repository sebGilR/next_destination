Module Api::V1
  class SessionsController < ApplicationController
    def create
      user = User.find(login_params)

      if user.nil?
        render json: {status: :unprocessable_entity, message: "Invalid username"}
      else
        session[:username] = user.username
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