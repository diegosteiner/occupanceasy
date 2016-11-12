# frozen_string_literal: true
module Api
  module V1
    class OccupiableResource < ApplicationResource
      attributes :description
      has_many :occupancies
      has_many :reservation_requests
    end
  end
end
