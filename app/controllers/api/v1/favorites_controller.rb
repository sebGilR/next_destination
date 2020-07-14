module Api::V1
  class FavoritesController < ApplicationController
    before_action :set_favorite, only: :destroy
    before_action :require_login

    def index
      favorites = current_user.favorites
      render json: { favorites: favorites }
    end

    def create
      favorite = current_user.favorites.build(favorite_params)
      if favorite.save
        render json: { favorite: favorite }
      else
        render json: { favorite: favorite.errors }
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
