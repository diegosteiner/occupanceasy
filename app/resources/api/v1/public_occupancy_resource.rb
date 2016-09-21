# frozen_string_literal: true
module Api
  module V1
    class PublicOccupancyResource < ApplicationResource
      attributes :id, :begins_at, :ends_at
      belongs_to :occupiable
    end
  end
end
