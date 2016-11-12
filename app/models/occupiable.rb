# frozen_string_literal: true
class Occupiable < ApplicationRecord
  belongs_to :api_access, inverse_of: :occupiables
  has_many :bookings

  def occupancies
    bookings.occupancies
  end

  def occupancy_ids
    occupancies.ids
  end
end
