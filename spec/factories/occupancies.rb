# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "reservation#{n}@occupanceasy.ch"
  end

  factory :reservation do
    type Reservation
    contact_email { generate(:email) }
    begins_at { 1.week.from_now }
    ends_at { begins_at + 1.week }
    association :occupiable, factory: :home
  end
end
