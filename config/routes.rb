# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :occupiables
    end
  end
  namespace :api do
    namespace :v1 do
      resources :occupiables, only: :show do
        resources :bookings, shallow: true, only: [:show, :create, :index]
      end

      namespace :manage do
        resources :bookings
        resources :occupiables do
        end
      end
      # jsonapi_resources :occupancies, except: :index
    end
  end
end
