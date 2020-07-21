module Api
  module V1
    # Destinations controller
    class DestinationsController < ApplicationController
      include UserConcern
      before_action :set_destination, only: %i[show update destroy]
      before_action :require_login, only: %i[create update destroy]

      def index
        destinations = Destination.order_by_most_favorites
        render json: { destinations: destinations }
      end

      def show
        render json: { destination: @destination }
      end

      def create
        destination = Destination.new(destination_params)
        if !@current_user.admin
          head :unauthorized
        elsif destination.save
          render json: { destination: destination }
        else
          render json: { destination: destination.errors }
        end
      end

      def update
        if !@current_user.admin
          head :unauthorized
        elsif @destination.update(destination_params)
          head :ok
        else
          render json: { destination: @destination.errors }
        end
      end

      def destroy
        if !@current_user.admin
          head :unauthorized
        else
          @destination.destroy
          head :ok
        end
      end

      private

      def destination_params
        params.permit(:name, :description, :img_url)
      end

      def set_destination
        @destination = Destination.find(params[:id])
      end
    end
  end
end
