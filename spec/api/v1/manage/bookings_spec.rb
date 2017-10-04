# frozen_string_literal: true

require 'rails_helper'
require 'support/jsonapi_helper'

xdescribe Api::V1::Manage::BookingsController, type: :request do
  let(:api_access) { create(:api_access) }
  let(:token) { api_access.private_key }
  let!(:occupiable) { create(:home, api_access: api_access) }
  let(:reservations) { create_list(:reservation, 2, occupiable: occupiable) }
  let(:reservation_requests) { create_list(:reservation_request, 2, occupiable: occupiable) }

  context 'unauthorized' do
    describe '#index' do
      subject! { get(api_v1_manage_bookings_path, headers: headers) }

      it_behaves_like 'unauthorized response'
    end
  end

  describe '#index' do
    let!(:bookings) { reservation_requests + reservations }
    let!(:other_bookings) { create_list(:reservation, 2) }
    subject! { get(api_v1_manage_bookings_path, headers: headers(token)) }

    it_behaves_like 'valid response'
    it { expect(data.map { |d| d['type'] }.uniq).to contain_exactly('bookings') }
    it { expect(data_ids).to contain_exactly(*bookings.map(&:id)) }
  end

  describe '#show' do
    let!(:booking) { reservations.sample }
    subject! { get(api_v1_manage_booking_path(booking), headers: headers(token)) }

    it_behaves_like 'valid response'
    it { expect(data).to include('id' => booking.to_param) }
  end

  describe '#create' do
    let(:new_booking) { build(:reservation, occupiable: occupiable) }
    let(:params) { JsonApiHelper.new.booking_to_jsonapi(new_booking) }
    subject! { post(api_v1_manage_bookings_path, headers: headers(token), params: params) }

    it { expect(response.status).to be 201 }
    it { expect(Booking.last.contact_email).to eq new_booking.contact_email }
  end

  describe '#update' do
    let(:booking) { reservations.sample }
    let(:changes) { { contact_email: 'someone@different.ch' } }
    let(:changed_booking) { booking.tap { |b| b.attributes = changes } }
    let(:params) { JsonApiHelper.new.booking_to_jsonapi(changed_booking) }
    subject! { patch(api_v1_manage_booking_path(changed_booking), headers: headers(token), params: params) }

    it_behaves_like 'valid response'
    it { expect(data['attributes']).to include changes.stringify_keys }
  end

  describe '#delete' do
    let(:booking) { reservations.sample }
    subject! { delete(api_v1_manage_booking_path(booking), headers: headers(token), params: {}) }

    it { expect(response.status).to be 204 }
    it { expect(Booking.all.map(&:id)).not_to include booking.id }
  end
end
