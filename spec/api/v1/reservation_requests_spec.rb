# frozen_string_literal: true
require 'rails_helper'
require 'support/jsonapi_helper'

describe Api::V1::BookingsController, type: :request do
  let!(:occupiable) { create(:home) }

  xdescribe '#index' do
    subject! { get(api_v1_bookings_path, headers: headers) }

    it_behaves_like 'not found response'
  end

  xdescribe '#show' do
    let!(:booking) { reservations.sample }
    subject! { get(api_v1_manage_booking_path(booking), headers: headers) }

    it_behaves_like 'valid response'
    it { expect(data).to include('id' => booking.to_param) }
  end

  describe '#create' do
    let(:new_booking) { build(:reservation_request, occupiable: occupiable) }
    let(:params) { JsonApiHelper.new.booking_to_jsonapi(new_booking) }
    subject! { post(api_v1_bookings_path, headers: headers, params: params) }

    it { pp parsed_json }
    it { expect(response.status).to be 201 }
    it { expect(Booking.last.contact_email).to eq new_booking.contact_email }
  end
end
