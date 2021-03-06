module Api
  module V1
    # Sessions controller
    class SessionsController < ApplicationController
      before_action :current_user, only: %i[connected destroy]

      def create
        user = User.find_by(username: params[:username])

        if user&.authenticate(params[:password])
          session[:username] = user.username
          render json:
          { connected: true, username: user.username,
            admin: user.admin, favorites: user.favorites }
        else
          head :unauthorized
        end
      end

      def connected
        if @current_user
          render json: {
            connected: true,
            username: @current_user.username,
            admin: @current_user.admin,
            favorites: @current_user.favorites
          }
        else
          render json: { connected: false }
        end
      end

      def destroy
        reset_session
        head :ok
      end

      def login_params
        params.permit(:username, :password)
      end
    end
  end
end
