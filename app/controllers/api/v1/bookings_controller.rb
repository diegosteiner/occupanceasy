# frozen_string_literal: true
module Api
  module V1
    class BookingsController < ApplicationController
      def index
        set_occupiable
        # TODO: Abstract data retrieval into service
        render json: @occupiable.occupancies, each_serializer: serializer
      end

      def show
        render json: Booking.occupancies.find(params[:id]), serializer: serializer
      end

      def create
        set_occupiable
        @booking = Booking.new((booking_params[:attributes] || {}).merge(occupiable: @occupiable, booking_type: :reservation_request))
        if @booking.save
          render json: @booking, status: :created, location: api_v1_booking_url(@booking), serializer: serializer
        else
          respond_with_errors(@booking)
        end
      end

      private

      def booking_params
        params.require(:data).permit(:type, {
          attributes: [:begins_at, :ends_at, :contact_email, :additional_data]
        })
      end

      def set_occupiable
        @occupiable = Occupiable.find(params[:occupiable_id])
      end

      def serializer
        Api::V1::BookingSerializer
      end
    end
  end
end
