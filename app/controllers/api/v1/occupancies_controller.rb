# frozen_string_literal: true
module Api
  module V1
    class OccupanciesController < ApplicationController
      before_action :set_occupiable, only: [:index, :create]
      before_action :set_occupancy, only: [:show]

      def index
        @occupancies = @occupiable.occupancies
        render json: @occupancies, meta: { total: @occupancies.count }
      end

      def show
        render json: @occupancy
      end

      def create
        @occupancy = Occupancy.new(occupancy_params)

        if @occupancy.save
          render json: @occupancy, status: :created
        else
          render_unprocessable(@occupancy)
        end
      end

      private

      def set_occupancy
        @occupancy = Occupancy.find(params[:id])
      end

      def set_occupiable
        @occupiable = Occupiable.find(params[:occupiable_id])
      end

      def occupancy_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
    end
  end
end
