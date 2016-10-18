# frozen_string_literal: true
module Api
  module V1
    module Manage
      class OccupiableResource < Api::V1::OccupiableResource
        def self.records(options = {})
          options[:context][:api_access].occupiables
        end
      end
    end
  end
end
