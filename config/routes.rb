# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :occupiables, only: :show do
        jsonapi_relationships only: :bookings
      end
      jsonapi_resources :bookings, only: :create

      namespace :manage do
        jsonapi_resources :bookings
        jsonapi_resources :occupiables do
          jsonapi_relationships
        end
      end
      # jsonapi_resources :occupancies, except: :index
    end
  end
end
