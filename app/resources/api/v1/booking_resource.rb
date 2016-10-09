# frozen_string_literal: true
module Api
  module V1
    class BookingResource < ApplicationResource
      attributes :begins_at, :ends_at, :blocking
      has_one :occupiable

      filter :begins_after, default: Time.zone.now.beginning_of_month,
        verify: ->(values, context) { 
        verify_date_filter(values, context) 
      },
      apply: -> (records, value, _options) {
        records.where(Booking.arel_table[:begins_at].gteq(value.last))
      }

      filter :ends_before, default: Time.zone.now.beginning_of_month + 1.year,

        verify: ->(values, context) { 
        verify_date_filter(values, context) 
      },
      apply: -> (records, value, _options) {
        records.where(Booking.arel_table[:ends_at].lteq(value.last))
      }

      private

      def verify_date_filter(values, context)
        values.map {|value| Time.iso8601(value) }
      end
    end
  end
end
