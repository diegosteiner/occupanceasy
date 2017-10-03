# frozen_string_literal: true

class PublicBookingService
  def list_upcoming_occupancies(occupiable)
    occupiable.bookings.upcoming
  end

  def show_reservation_with_token(token)
    Booking.find_by!(public_token: token)
  end

  def create_reservation_request(occupiable, attributes)
    attributes = attributes.merge(occupiable: occupiable, blocking: false)
    Booking.create(attributes)
  end
end
