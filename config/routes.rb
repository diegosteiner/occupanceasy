# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :occupiables, only: [] do
        resources :occupancies, shallow: true
      end
    end
  end
end
