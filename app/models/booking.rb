# frozen_string_literal: true

class Booking < ApplicationRecord
  has_paper_trail
  belongs_to :occupiable, inverse_of: :bookings

  scope :upcoming, ->(at = Time.zone.now) { where(arel_table[:ends_at].gteq(at)) }
  scope :overlapping, (lambda do |range|
    # TODO: fix
    where('(begins_at, ends_at) OVERLAPS (?::timestamp, ?::timestamp)', range.begin, range.end)
  end)

  validates :begins_at, :ends_at, presence: true
  validates :public_token, uniqueness: true
  validate do
    unless begins_at.present? && ends_at.present? && begins_at < ends_at
      errors.add :ends_at, I18n.t('greater_than', count: self.class.human_attribute_name(:begins_at))
    end
  end

  before_create :generate_public_token, unless: :public_token?

  def range
    begins_at..ends_at
  end

  def conflicting
    # occupiable.occupancies.overlapping(range).where.not(id: id, type: ReservationRequest.sti_name)
  end

  def generate_public_token
    self.public_token = SecureRandom.urlsafe_base64(40)
  end
end
