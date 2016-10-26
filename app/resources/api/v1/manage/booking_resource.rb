# frozen_string_literal: true
module Api
  module V1
    module Manage
      class BookingResource < ApplicationResource
        attributes :begins_at, :ends_at, :blocking, :booking_type, :contact_email, :additional_data
        has_one :occupiable

        def self.records(options = {})
          Booking.where(id: options[:context][:api_access].occupiables.map(&:booking_ids))
        end
      end
    end
  end
end
