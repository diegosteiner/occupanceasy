# frozen_string_literal: true
module Api
  module V1
    class ReservationRequestResource < ApplicationResource
      model_name 'Booking'
      attributes :begins_at, :ends_at, :blocking
      has_one :occupiable
    end
  end
end
