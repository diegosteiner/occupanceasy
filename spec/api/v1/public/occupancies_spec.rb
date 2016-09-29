# frozen_string_literal: true
require 'rails_helper'

def headers
  {
    'HTTP_ACCEPT' => 'application/vnd.api+json'
  }
end

BASE_PATH = '/api/v1/public'

describe 'Api::V1::Public::OccupanciesController', type: :request do
  let(:occupiable) { create(:home) }
  subject(:parsed_json) { JSON.parse(response.body) }
  let(:data) { parsed_json['data'] }
  let(:relationsships) { parsed_json['data'] }

  describe '#index' do
    let!(:occupancies) { create_list(:reservation, 10, occupiable: occupiable) }
    let!(:other_occupancies) { create(:reservation) }
    let!(:reservation_request) { create(:reservation_request, occupiable: occupiable) }

    context 'as resource of occupiable' do
      before { get("#{BASE_PATH}/occupiables/#{occupiable.to_param}/occupancies", headers: headers) }
      it do
        expect(response).to be_ok
        expect(response.content_type).to eq('application/vnd.api+json')
        expect(parsed_json['data'].count).to be(occupancies.count)
        expect(parsed_json['meta']).to eq('record-count' => occupancies.count)
      end
    end

    context 'top-level resource' do
      it { expect { get("#{BASE_PATH}/occupancies", headers: headers) }.to raise_error(ActionController::RoutingError) }
    end
  end

  describe '#show' do
    let!(:occupancy) { create(:reservation, occupiable: occupiable) }

    before { get("#{BASE_PATH}/occupancies/#{occupancy.to_param}") }
    it do
      expect(response).to be_ok
      expect(parsed_json['data']['type']).to eq('reservations')
    end

    context 'with invalid occupancy' do
      it { expect { get("#{BASE_PATH}/occupancies/404", headers: headers) }.to raise_error(ActionController::RoutingError) }
    end
  end

  def to_jsonapi(occupancy)
    {
      data: {
        type: occupancy.model_name.plural,
        attributes: extract_attributes(occupancy)
      }
    }.deep_stringify_keys
  end

  def extract_attributes(occupancy)
    attributes = occupancy.additional_data || {}
    attributes.merge!(occupancy.attributes.except(*%w(id created_at updated_at type additional_data blocking)))
  end

  xdescribe '#create' do
    let(:occupancy) { build(:reservation, occupiable: occupiable) }
    let(:occupancy_json) { to_jsonapi(occupancy) }
    before { post("/api/v1/occupiables/#{occupiable.to_param}/occupancies", params: occupancy_json) }

    context 'with valid occupancy' do
      it do
        expect(response.status).to eq(201)
        expect(Occupancy.count).to be(1)
      end
    end

    context 'with invalid occupancy' do
      let(:occupancy) { build(:reservation, begins_at: nil, ends_at: nil, occupiable: occupiable) }
      it do
        expect(response.status).to eq(422)
        expect(Occupancy.count).to be(0)
      end
    end
  end
end
