# frozen_string_literal: true
require 'rails_helper'

describe 'Api::V1::OccupanciesController', type: :request do
  describe 'get list of all occupancies of a occupiable' do
    let(:occupiable) { create(:home) }
    let!(:occupancies) { create_list(:reservation, 10, occupiable: occupiable) }
    let!(:reservation_request) { create(:reservation_request, occupiable: occupiable) }
    subject(:parsed_json) { JSON.parse(response.body) }
    before { get("/api/v1/occupiables/#{occupiable.to_param}/occupancies") }

    it do
      expect(response).to be_ok
      expect(parsed_json['data'].count).to be(10)
      expect(parsed_json['meta']).to eq('total' => occupancies.count)
    end
  end
end
