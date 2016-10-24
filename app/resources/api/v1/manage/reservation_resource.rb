# frozen_string_literal: true
module Api
  module V1
    module Manage
      class ReservationResource < Api::V1::BookingResource
        model_hint resource: BookingResource
      end
    end
  end
end
