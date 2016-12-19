# frozen_string_literal: true
module Api
  module V1
    class BookingsController < ApplicationController
      def index
        set_occupiable
        render json: booking_service.upcoming_occupancies, each_serializer: serializer
      end

      def show
        render json: booking_service.with_token(params[:id]), serializer: serializer
      end

      def create
        set_occupiable
        @booking = booking_service.reservation_request(booking_params[:attributes] || {})
        if @booking.save
          render json: @booking, status: :created, location: api_v1_booking_url(@booking), serializer: serializer
        else
          respond_with_unprocessable_entry(@booking)
        end
      end

      private

      def booking_params
        params.require(:data).permit(:type, attributes: [:begins_at, :ends_at, :contact_email, :additional_data,
                                                         :begins_at_specific_time, :ends_at_specific_time])
      end

      def serializer
        Api::V1::BookingSerializer
      end

      def set_occupiable
        @occupiable = Occupiable.find(params[:occupiable_id])
      end

      def booking_service
        @booking_service ||= BookingService.new(@occupiable)
      end
    end
  end
end
