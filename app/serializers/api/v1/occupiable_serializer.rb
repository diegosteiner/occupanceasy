# frozen_string_literal: true

module Api
  module V1
    class OccupiableSerializer < ApplicationSerializer
      attributes :id, :description

      has_many :bookings
      link(:self) { api_v1_occupiable_path(object.id) }
    end
  end
end
