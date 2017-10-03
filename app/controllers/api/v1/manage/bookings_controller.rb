# frozen_string_literal: true

module Api
  module V1
    module Manage
      class BookingsController < ApplicationController
        def index
          set_occupiable
          render json: @occupiable.occupancies, each_serializer: serializer
        end

        def show
          set_occupiable
          render json: @occupiable, serializer: serializer
        end

        private

        def set_occupiable
          @occupiable = Occupiable.find(params[:occupiable_id])
        end

        def serializer
          Api::V1::Manage::BookingSerializer
        end
      end
    end
  end
end
