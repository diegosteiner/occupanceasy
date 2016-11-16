# frozen_string_literal: true
module Api
  module V1
    module Manage
      class OccupiableResource < ApplicationResource
        attributes :description
        has_many :bookings
        has_many :occupancies, class_name: 'Occupancy'

        def self.records(options = {})
          options[:context][:api_access].occupiables
        end

        before_save do
          @model.api_access = context[:api_access]
        end
      end
    end
  end
end
