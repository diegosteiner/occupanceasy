# frozen_string_literal: true
class Occupiable < ApplicationRecord
  belongs_to :access, inverse_of: :occupiables
  has_many :occupancies, inverse_of: :occupiable
end
