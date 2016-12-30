# frozen_string_literal: true
class Booking < ApplicationRecord
  belongs_to :occupiable, inverse_of: :bookings
  enum booking_type: [:reservation_request, :reservation, :closedown]

  scope :occupancies, ->() { where(booking_type: [:reservation, :closedown]) }
  scope :upcoming, ->(at = Time.zone.now) { where(arel_table[:ends_at].gteq(at)) }
  scope :overlapping, (lambda do |range|
    where('(begins_at, ends_at) OVERLAPS (?::timestamp, ?::timestamp)', range.begin, range.end)
  end)

  validates :begins_at, :ends_at, presence: true
  validates :token, uniqueness: true
  validate do
    unless begins_at.present? && ends_at.present? && begins_at < ends_at
      # TODO: I18nify
      errors.add :base, 'begins_at needs to be before ends_at'
    end
  end

  before_create :generate_token, unless: :token?

  def range
    begins_at..ends_at
  end

  def conflicting
    # occupiable.occupancies.overlapping(range).where.not(id: id, type: ReservationRequest.sti_name)
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64(40)
  end

  def to_param
    token
  end
end
