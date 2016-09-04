# frozen_string_literal: true
module Api
  module V1
    class OccupanciesController < ApplicationController
      before_action :set_occupiable

      def index
        @occupancies = @occupiable.occupancies
        render json: @occupancies, meta: { total: @occupancies.count }
      end

      private

      def set_occupiable
        @occupiable = Occupiable.find(params[:occupiable_id])
      end
    end
  end
end
