# frozen_string_literal: true
module Api
  module V1
    module Manage
      class BookingResource < Api::V1::BookingResource
        def self.records(options = {})
          Booking.where(id: options[:context][:api_access].occupiables.map(&:booking_ids))
        end
      end
    end
  end
end
