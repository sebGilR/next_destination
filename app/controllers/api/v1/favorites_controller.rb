module Api::V1
  class FavoritesController < ApplicationController
    before_action :set_favorite, only: :destroy

    def index
      favorites = Favorite.find_by(user_id: params[:user_id])
      render json: {
        status: 'SUCCESS',
        message: 'Favorites loaded',
        data: favorites }
    end

    def create
      favorite = Favorite.new(favorite_params)
      if favorite.save
        render json: {
          status: 'SUCCESS',
          message: 'Favorite created',
          data: favorite }
      else
        render json: {
          status: :unprocessable_entity,
          message: "Favorite failed to save",
          data: favorite.errors }
      end
    end
  
    def destroy
      @favorite.destroy
      head :ok
    end

    private

    def favorite_params
      params.permit(:user_id, :destination_id)
    end

    def set_favorite
      @favorite = Favorite.find(params[:id])
    end
  end
end
