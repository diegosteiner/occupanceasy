# frozen_string_literal: true
module Api
  module V1
    module Manage
      class OccupiableResource < Api::V1::OccupiableResource
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
