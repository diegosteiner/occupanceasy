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
    context 'with valid token' do
      let!(:booking) { reservations.sample }
      subject! { get(api_v1_booking_path(booking.public_token), headers: headers) }

      it do
        expect(jsonapi_response).to be_ok
        expect(jsonapi_response.data.id).to eq(booking.id)
      end
    end

    context 'with invalid token' do
      subject! { get(api_v1_booking_path(id: SecureRandom.urlsafe_base64), headers: headers) }

      it { expect(jsonapi_response.status).to be 404 }
    end
  end

  describe '#create' do
    subject! do
      post(api_v1_occupiable_bookings_path(occupiable),
           headers: headers,
           params: {
             data: {
               attributes: request.slice(:begins_at, :ends_at, :contact_email, :booking_type)
             }
           }.to_json)
    end
    context 'with valid data' do
      let(:request) { attributes_for(:reservation, occupiable: occupiable, additional_data: { test: 'test' }) }
      it do
        expect(jsonapi_response).to be_ok
        expect(jsonapi_response.data.attributes.begins_at.to_time.to_i).to eq request[:begins_at].to_time.to_i
        expect(jsonapi_response.data.attributes.ends_at.to_time.to_i).to eq request[:ends_at].to_time.to_i
        expect(jsonapi_response.data.attributes.booking_type).to eq('reservation_request')
      end
    end

    context 'with invalid data' do
      let(:request) { attributes_for(:reservation, occupiable: occupiable, ends_at: 3.years.ago) }
      it do
        expect(jsonapi_response.status).to be 422
      end
    end
  end
end
