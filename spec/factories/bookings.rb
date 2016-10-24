# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "reservation#{n}@occupanceasy.ch"
  end

  factory :booking do
    contact_email { generate(:email) }
    begins_at { 1.week.from_now }
    ends_at { begins_at + 1.week }
    association :occupiable, factory: :home
    booking_type Booking.booking_types[:reservation]

    factory :closedown do
      booking_type Booking.booking_types[:closedown]
    end

    factory :reservation_request do
      booking_type Booking.booking_types[:reservation_request]
    end

    factory :reservation do
      booking_type Booking.booking_types[:reservation]
      factory :reservation_with_additional_data do
        additional_data { { name: 'Eugen Weber', organization: 'Pfadiheime' } }
      end
    end
  end
end
