# frozen_string_literal: true
class Occupiable < ApplicationRecord
  belongs_to :api_access, inverse_of: :occupiables
  has_many :bookings
  has_many :occupancies
end
