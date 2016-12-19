# frozen_string_literal: true
module Api
  module V1
    class BookingSerializer < ApplicationSerializer
      attributes :begins_at, :ends_at, :blocking, :booking_type, :begins_at_specific_time, :ends_at_specific_time
      has_one :occupiable

      #      include ::Api::V1::DateFilterable
    end
  end
end
