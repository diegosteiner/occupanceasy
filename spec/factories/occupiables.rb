# frozen_string_literal: true
FactoryGirl.define do
  factory :occupiable do
    description 'Occupiable'
    api_access

    factory :home do
      description 'Pfadiheim'
    end
  end
end
