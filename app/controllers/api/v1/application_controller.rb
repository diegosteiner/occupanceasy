# frozen_string_literal: true
module Api
  module V1
    class ApplicationController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :respond_with_not_found

      private

      def respond_with_unprocessable_entry(object)
        render json: { errors: ErrorSerializer.serialize(object) }, status: :unprocessable_entity
      end

      def respond_with_not_found(error)
        render json: { error: error.message }, status: :not_found
      end
    end
  end
end
