# frozen_string_literal: true
module Api
  module V1
    class OccupiableResource < ApplicationResource
      attributes :description
      has_many :occupancies, class_name: 'Occupancy'
      has_many :reservation_requests, class_name: 'ReservationRequest'
    end
  end
end
