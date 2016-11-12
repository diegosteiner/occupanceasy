# frozen_string_literal: true
module Api
  module V1
    module Manage
    class ApplicationController < ActionController::API
        before_action :authenticate

        protected

        def authenticate
          render json: {}, status: 403 unless context[:api_access].present?
        end

        def context
          {
            api_access: authentication_token
          }
        end

        def authentication_token
          token, _options = ActionController::HttpAuthentication::Token.token_and_options(request)
          token ||= params[:token]
          ApiAccess.find_by(private_key: token)
        end
      end
    end
  end
end
