# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :occupiables do
        jsonapi_relationships
      end
      jsonapi_resources :occupancies
    end
  end
end
