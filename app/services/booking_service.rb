# frozen_string_literal: true
class BookingService
  def list_upcoming_occupancies(occupiable)
    occupiable.occupancies.upcoming
  end

  def show_reservation_with_token(token)
    Booking.where(booking_type: [:reservation_request, :reservation]).find_by!(token: token)
  end

  def create_reservation_request(occupiable, attributes)
    attributes = attributes.merge(occupiable: occupiable, booking_type: :reservation_request)
    Booking.new(attributes)
  end
end
