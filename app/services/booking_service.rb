# frozen_string_literal: true
class BookingService
  attr_reader :occupiable

  def initialize(occupiable)
    @occupiable = occupiable
  end

  def upcoming_occupancies
    occupiable.occupancies.upcoming
  end

  def with_token(token)
    Booking.where(booking_type: [:reservation_request, :reservation]).find_by!(token: token)
  end

  def reservation_request(attributes)
    attributes = attributes.merge(occupiable: @occupiable, booking_type: :reservation_request)
    Booking.new(attributes)
  end
end
