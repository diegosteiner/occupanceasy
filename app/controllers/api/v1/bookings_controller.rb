# frozen_string_literal: true
module Api
  module V1
    class BookingsController < ApplicationController
      before_action :set_occupiable, only: [:index, :create]

      def index
        render json: @occupiable.occupancies, each_serializer: serializer
      end

      def show
        render json: @occupiable, serializer: serializer
      end

      private
      def set_occupiable
        @occupiable = Occupiable.find(params[:occupiable_id])
      end

      def serializer
        Api::V1::BookingSerializer
      end
    end
  end
end
