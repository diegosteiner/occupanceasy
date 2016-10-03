# frozen_string_literal: true
module Api
  module V1
    class ReservationRequestResource < ApplicationResource
      attributes :id, :begins_at, :ends_at, :blocking
      belongs_to :occupiable
    end
  end
end
