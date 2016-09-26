# frozen_string_literal: true
require 'rails_helper'

def headers
  {
    'HTTP_ACCEPT' => 'application/vnd.api+json'
  }
end

describe 'Api::V1::OccupanciesController', type: :request do
  let(:occupiable) { create(:home) }
  subject(:parsed_json) { JSON.parse(response.body) }
  let(:data) { parsed_json['data'] }
  let(:relationsships) { parsed_json['data'] }

  describe '#index' do
    let!(:occupancies) { create_list(:reservation, 10, occupiable: occupiable) }
    let!(:reservation_request) { create(:reservation_request, occupiable: occupiable) }
    before { get("/api/v1/occupiables/#{occupiable.to_param}", headers: headers) }

    it do
      puts parsed_json.inspect
      expect(response).to be_ok
      expect(response.content_type).to eq('application/vnd.api+json')
    end
  end

  xdescribe '#index' do
    let!(:occupancies) { create_list(:reservation, 10, occupiable: occupiable) }
    let!(:reservation_request) { create(:reservation_request, occupiable: occupiable) }
    before { get('/api/v1/occupancies') }

    it do
      expect(response).to be_ok
      expect(parsed_json['data'].count).to be(10)
      expect(parsed_json['meta']).to eq('total' => occupancies.count)
    end
  end

  xdescribe '#show' do
    let(:occupancy) { create(:reservation, occupiable: occupiable) }

    context 'with valid occupancy' do
      before { get("/api/v1/occupancies/#{occupancy.to_param}") }
      it do
        expect(response).to be_ok
        expect(parsed_json['data']['type']).to eq('reservations')
      end
    end

    context 'with invalid occupancy' do
      before { get('/api/v1/occupancies/404') }
      it do
        expect(response.status).to eq(404)
        expect(parsed_json['errors']).to include('status' => 404)
      end
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
