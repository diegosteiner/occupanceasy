# frozen_string_literal: true
require 'rails_helper'
require 'support/jsonapi_helper'

describe Api::V1::Manage::OccupiablesController, type: :request do
  let(:api_access) { create(:api_access) }
  let(:token) { api_access.private_key }
  let!(:occupiable) { create(:home, api_access: api_access) }
  let(:params) { {} }

  context 'unauthorized' do
    describe '#index' do
      subject { get(api_v1_manage_occupiables_path, headers: headers) }

      it_behaves_like 'unauthorized response'
    end
  end

  describe '#index' do
    let!(:occupiables) { [occupiable] }
    subject { get(api_v1_manage_occupiables_path, headers: headers(token)) }

    it_behaves_like 'valid response'
    it do
      expect(subject)
      expect(data_ids).to contain_exactly(occupiable.id)
    end
  end

  describe '#show' do
    let!(:other_occupiable) { create(:home) }
    subject { get(api_v1_manage_occupiable_path(occupiable), headers: headers(token)) }

    it_behaves_like 'valid response'
  end

  describe '#show/bookings' do
    subject { get(api_v1_manage_occupiable_bookings_path(occupiable, params), headers: headers(token)) }
    let!(:bookings) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.weeks.from_now) }

    it_behaves_like 'valid response'
    it { expect(data.count).to be(bookings.count) }
  end
end
