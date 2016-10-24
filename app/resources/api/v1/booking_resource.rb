# frozen_string_literal: true
module Api
  module V1
    class BookingResource < ApplicationResource
      attributes :begins_at, :ends_at, :blocking, :booking_type
      model_hint model: Booking, resource: BookingResource
      has_one :occupiable

      filter :begins_after, default: Time.zone.now.beginning_of_month,
                            apply: lambda { |records, value, _options|
                                     records.where(Booking.arel_table[:begins_at].gteq(value.last))
                                   }

      filter :ends_before, default: Time.zone.now.beginning_of_month + 1.year,
                           apply: lambda { |records, value, _options|
                                    records.where(Booking.arel_table[:ends_at].lteq(value.last))
                                  }
    end
  end
end
