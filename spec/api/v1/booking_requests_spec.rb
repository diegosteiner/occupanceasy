# frozen_string_literal: true
require 'rails_helper'
require 'support/jsonapi_helper'

describe Api::V1::BookingsController, type: :request do
  let!(:occupiable) { create(:home) }
  let!(:reservations) { create_list(:reservation, 3, occupiable: occupiable) }

  describe '#index' do
    let!(:reservation_requests) { create_list(:reservation_request, 1, occupiable: occupiable) }
    subject! { get(api_v1_occupiable_bookings_path(occupiable), headers: headers) }

    it do
      expect(jsonapi_response).to be_ok
      expect(jsonapi_response.data.map(&:id)).to eq(reservations.map(&:id))
    end
  end

  describe '#show' do
    let!(:booking) { reservations.sample }
    subject! { get(api_v1_booking_path(booking), headers: headers) }

    it do
      expect(jsonapi_response).to be_ok
      expect(jsonapi_response.data.id).to eq(booking.id)
    end
  end

  describe '#create' do
    context 'with valid data' do
      let(:new_booking) { attributes_for(:reservation, occupiable: occupiable, additional_data: { test: 'test' }) }
      subject! do
        post(api_v1_occupiable_bookings_path(occupiable),
             headers: headers,
             params: {
               data: {
                 attributes: new_booking.slice(:begins_at, :ends_at, :contact_email, :booking_type)
               }
             }.to_json)
      end

      it do
        expect(jsonapi_response).to be_ok
        expect(jsonapi_response.data.attributes.begins_at.to_time.to_i).to eq new_booking[:begins_at].to_time.to_i
        expect(jsonapi_response.data.attributes.ends_at.to_time.to_i).to eq new_booking[:ends_at].to_time.to_i
        expect(jsonapi_response.data.attributes.booking_type).to eq('reservation_request')
      end
    end
  end
end
