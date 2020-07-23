module Api
  module V1
    # User controller
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          session[:username] = user.username
          render json:
          { connected: true, username: user.username, admin: user.admin,
            favorites: user.favorites }
        else
          render json: { user: user.errors }
        end
      end

      private

      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
    end
  end
end
