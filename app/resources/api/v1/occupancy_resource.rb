# frozen_string_literal: true
module Api
  module V1
    class OccupancyResource < ApplicationResource
      attributes :begins_at, :ends_at, :created_at, :updated_at, :contact_email
      has_one :occupiable

      def attributes(attrs)
        additional_data = object.additional_data || {}
        additional_data.merge(super(attrs))
      end
    end
  end
end
