# frozen_string_literal: true

FactoryGirl.define do
  sequence :email do |n|
    "reservation#{n}@occupanceasy.ch"
  end

  factory :booking do
    # contact_email { generate(:email) }
    begins_at { 1.week.from_now }
    ends_at { begins_at + 1.week }
    association :occupiable, factory: :home
    blocking true

    factory :closedown do
    end

    factory :reservation_request do
      blocking false
    end

    factory :reservation do
    end
  end
end
