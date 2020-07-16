module Api::V1
  class DestinationsController < ApplicationController
    include UserConcern
    before_action :set_destination, only: [:show, :update, :destroy]
    before_action :require_login, only: [:create, :update, :destroy]

    def index
      destinations = Destination.order_by_most_favorites
      render json: { destinations: destinations }
    end

    def show
      render json: { destination: @destination }
    end
  
    def create
      destination = Destination.new(destination_params)
      if destination.save
        render json: { destination: destination }
      else
        render json: { destination: destination.errors }
      end
    end
  
    def update
      if @destination.update(destination_params)
        head :ok
      else
        render json: { destination: @destination.errors }
      end
    end
  
    def destroy
      @destination.destroy
      head :ok
    end

    private

    def destination_params
      params.permit(:name, :description)
    end

    def set_destination
      @destination = Destination.find(params[:id])
    end
  end
end
