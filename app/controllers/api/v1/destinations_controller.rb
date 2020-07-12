module Api::V1
  class DestinationsController < ApplicationController
    before_action :set_destination, only: [:show, :update, :destroy]

    def index
      destinations = Destination.order_by_most_favorites
      render json: {
        status: 'SUCCESS',
        message: 'Destinations loaded',
        data: destinations }
    end

    def show
      render json: {
        status: 'SUCCESS',
        message: "Destination loaded",
        data: @destination }
    end
  
    def create
      destination = Destination.new(destination_params)
      if destination.save
        render json: {
          status: 'SUCCESS',
          message: 'Destinations created',
          data: destination }
      else
        render json: {
          status: :unprocessable_entity,
          message: "Destination failed to save",
          data: destination.errors }
      end
    end
  
    def update
      if @destination.update(destination_params)
        head :ok
      else
        render json: {
          status: :unprocessable_entity,
          message: "Destination failed to update",
          data: @destination.errors }
      end
    end
  
    def destroy
      @destination.destroy
      head :ok
    end

    private

    def destination_params
      params.require(:destination).permit(:name, :description)
    end

    def set_destination
      @destination = Destination.find(params[:id])
    end
  end
end
