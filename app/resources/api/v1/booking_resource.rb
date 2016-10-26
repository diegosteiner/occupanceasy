# frozen_string_literal: true
module Api
  module V1
    class BookingResource < ApplicationResource
      attributes :begins_at, :ends_at, :blocking, :booking_type
      has_one :occupiable

      include ::Api::V1::DateFilterable
    end
  end
end
