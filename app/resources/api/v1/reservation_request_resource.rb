# frozen_string_literal: true
module Api
  module V1
    class ReservationRequestResource < ApplicationResource
      model_name 'Booking'
      attributes :begins_at, :ends_at, :blocking, :booking_type, :contact_email
      has_one :occupiable

      before_save do
        @model.booking_type = Booking.booking_types[:reservation_request]
      end
    end
  end
end
