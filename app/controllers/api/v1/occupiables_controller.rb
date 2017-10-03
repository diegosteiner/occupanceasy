# frozen_string_literal: true

module Api
  module V1
    class OccupiablesController < ApplicationController
      before_action :set_occupiable, only: [:show]

      def show
        render json: @occupiable, serializer: serializer
      end

      private

      def set_occupiable
        @occupiable = Occupiable.find(params[:id])
      end

      def serializer
        Api::V1::OccupiableSerializer
      end
    end
  end
end
