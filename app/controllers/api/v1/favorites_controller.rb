module Api::V1
  class FavoritesController < ApplicationController
    include UserConcern
    before_action :set_favorite, only: :destroy
    before_action :require_login

    def index
      favorites = @current_user.favorites
      render json: { favorites: favorites }
    end

    def create
      favorite = @current_user.favorites.build(favorite_params)
      if favorite.save
        render json: {
          connected: true,
          username: @current_user.username,
          admin: @current_user.admin,
          favorites: @current_user.favorites.include?(favorite) ?
            @current_user.favorites :
            @current_user.favorites + [favorite],
        }
      else
        head :bad_request
      end
    end
  
    def destroy
      @favorite.destroy
      head :ok
    end

    private

    def favorite_params
      params.permit(:destination_id)
    end

    def set_favorite
      @favorite = Favorite.find(params[:id])
    end
  end
end
