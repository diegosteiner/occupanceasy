# frozen_string_literal: true
module Api
  module V1
    module Manage
      class OccupiableResource < ApplicationResource
        attributes :description
        has_many :bookings
      end
    end
  end
end
