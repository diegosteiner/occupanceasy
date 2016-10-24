# frozen_string_literal: true
class Booking < ApplicationRecord
  belongs_to :occupiable, inverse_of: :bookings
  enum booking_types: [:reservation_request, :reservation, :closedown]

  scope :overlapping, (lambda do |range|
    where('(begins_at, ends_at) OVERLAPS (?::timestamp, ?::timestamp)', range.begin, range.end)
  end)

  validates :begins_at, :ends_at, presence: true
  validate do
    unless begins_at.present? && ends_at.present? && begins_at < ends_at
      errors.add :base, 'begins_at needs to be before ends_at'
    end
  end

  def range
    begins_at..ends_at
  end

  def conflicting
    occupiable.occupancies.overlapping(range).where.not(id: id, type: ReservationRequest.sti_name)
  end
end
