# frozen_string_literal: true
module Api
  module V1
    module Manage
      class BookingResource < ApplicationResource
        attributes :begins_at, :ends_at, :blocking
        has_one :occupiable
      end
    end
  end
end
