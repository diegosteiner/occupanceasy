# frozen_string_literal: true

require 'rails_helper'
require 'support/jsonapi_helper'

xdescribe Api::V1::Manage::OccupiablesController, type: :request do
  let(:api_access) { create(:api_access) }
  let(:token) { api_access.private_key }
  let!(:occupiable) { create(:home, api_access: api_access) }
  let(:serialized) { ActiveModelSerializers::SerializableResource.new(occupancy).to_json }

  context 'unauthorized' do
    describe '#index' do
      subject! { get(api_v1_manage_occupiables_path, headers: headers) }

      it_behaves_like 'unauthorized response'
    end
  end

  describe '#index' do
    subject! { get(api_v1_manage_occupiables_path, headers: headers(token)) }

    it_behaves_like 'valid response'
    it { expect(data_ids).to contain_exactly(occupiable.id) }
  end

  describe '#show' do
    let!(:other_occupiable) { create(:home) }
    subject! { get(api_v1_manage_occupiable_path(occupiable), headers: headers(token)) }

    it_behaves_like 'valid response'
  end

  describe '#create' do
    let(:occupiable) { build(:home) }
    let(:params) { serialized }
    subject! { post(api_v1_manage_occupiables_path, headers: headers(token), params: params) }

    it { expect(response.status).to be 201 }
  end

  describe '#update' do
    let(:changes) { { 'description' => 'new value' } }
    let(:params) { { data: { type: :occupiables, id: occupiable.id, attributes: changes } }.to_json }
    subject! { patch(api_v1_manage_occupiable_path(occupiable), headers: headers(token), params: params) }

    it_behaves_like 'valid response'
    it { expect(data['attributes']).to include changes }
  end

  describe '#delete' do
    subject! { delete(api_v1_manage_occupiable_path(occupiable), headers: headers(token), params: {}) }

    it { expect(response.status).to be 204 }
  end

  xdescribe '#show/bookings' do
    let!(:bookings) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.weeks.from_now) }
    subject! { get(api_v1_manage_occupiable_bookings_path(occupiable), headers: headers(token)) }

    it { expect(data.count).to(be(bookings.count)) }
    it_behaves_like 'valid response'
  end
end
