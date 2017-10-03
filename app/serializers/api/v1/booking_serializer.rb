# frozen_string_literal: true

module Api
  module V1
    class BookingSerializer < ApplicationSerializer
      attributes :begins_at, :ends_at, :blocking

      has_one :occupiable, serializer: Api::V1::OccupiableSerializer do
        link(:related) { api_v1_occupiable_path(id: object.occupiable_id) }
      end

      link(:self) { api_v1_booking_path(object.id) }

      #      include ::Api::V1::DateFilterable
    end
  end
end
