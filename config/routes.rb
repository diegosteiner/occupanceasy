# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :occupiables, only: :show do
        jsonapi_relationships only: :bookings
      end
      jsonapi_resources :reservation_requests, except: :index

      namespace :manage do
        jsonapi_resources :bookings, except: :index
      end
      # jsonapi_resources :occupancies, except: :index
    end
  end
end
