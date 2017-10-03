# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      def index
        set_occupiable
        render json: booking_service.list_upcoming_occupancies(@occupiable), each_serializer: BookingSerializer
      end

      def show
        render json: booking_service.show_reservation_with_token(params[:id]), serializer: BookingSerializer
      end

      def create
        set_occupiable
        @booking = booking_service.create_reservation_request(@occupiable, booking_params[:attributes] || {})
        if @booking.save
          render json: @booking, status: :created, location: api_v1_booking_url(@booking), serializer: BookingSerializer
        else
          respond_with_unprocessable_entry(@booking)
        end
      end

      private

      def booking_params
        params.require(:data).permit(:type, attributes: %i[begins_at ends_at contact_email additional_data
                                                           begins_at_specific_time ends_at_specific_time])
      end

      def set_occupiable
        @occupiable = Occupiable.find(params[:occupiable_id])
      end

      def booking_service
        @booking_service ||= PublicBookingService.new
      end
    end
  end
end
