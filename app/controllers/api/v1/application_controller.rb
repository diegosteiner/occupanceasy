# frozen_string_literal: true
module Api
  module V1
    class ApplicationController < ::ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      def render_not_found
        render json: { errors: [{ status: 404 }] }, status: 404
      end

      def render_unprocessable(resource)
        errors = resource.errors.messages.map do |attribute, errs|
          errs.map do |error_message|
            {
              status: 422,
              source: { pointer: "/data/attributes/#{attribute}" },
              detail: error_message
            }
          end
        end.flatten

        render json: { errors: errors }, status: 422
      end
    end
  end
end
