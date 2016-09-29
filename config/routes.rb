# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :public do
        jsonapi_resources :occupiables do
          jsonapi_relationships
        end
        jsonapi_resources :reservation_requests, except: :index
        jsonapi_resources :bookings, except: :index
      end
      # jsonapi_resources :occupancies, except: :index
    end
  end
end
