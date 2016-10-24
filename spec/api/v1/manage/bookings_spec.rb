# frozen_string_literal: true
require 'rails_helper'
require 'support/jsonapi_helper'

describe Api::V1::Manage::BookingsController, type: :request do
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
    it { expect(data.map { |d| d['type'] }).to contain_exactly('bookings') }
    it {  puts response.body }
    it { expect(data_ids).to contain_exactly(*bookings.map(&:id)) }
  end

  xdescribe '#show' do
    let!(:other_occupiable) { create(:home) }
    subject! { get(api_v1_manage_occupiable_path(occupiable), headers: headers(token)) }

    it_behaves_like 'valid response'
  end

  xdescribe '#create' do
    let(:occupiable) { build(:home) }
    let(:params) { { data: { type: :occupiables, attributes: occupiable.attributes.slice('description') } }.to_json }
    subject! { post(api_v1_manage_occupiables_path, headers: headers(token), params: params) }

    it { expect(response.status).to be 201 }
  end

  xdescribe '#update' do
    let(:changes) { { 'description' => 'new value' } }
    let(:params) { { data: { type: :occupiables, id: occupiable.id, attributes: changes } }.to_json }
    subject! { patch(api_v1_manage_occupiable_path(occupiable), headers: headers(token), params: params) }

    it_behaves_like 'valid response'
    it { expect(data['attributes']).to include changes }
  end

  xdescribe '#delete' do
    subject! { delete(api_v1_manage_occupiable_path(occupiable), headers: headers(token), params: {}) }

    it { expect(response.status).to be 204 }
  end
end
