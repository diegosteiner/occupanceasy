# frozen_string_literal: true
require 'rails_helper'

def headers
  {
    'HTTP_ACCEPT' => 'application/vnd.api+json'
  }
end

def occupiables_path(id = nil, relationships = nil, params = {})
  path = String.new('/api/v1/occupiables')
  path << '/' << id.to_s if id.present?
  path << '/' << relationships.to_s if relationships.present?
  path << '?' << params.map { |key, value| "#{key}=#{value}" }.join('&') if params.present?
  path
end

describe 'Api::V1::OccupanciesController', type: :request do
  let(:occupiable) { create(:home) }
  subject(:parsed_json) { JSON.parse(response.body) }
  let(:data) { parsed_json['data'] }
  let(:relationsships) { data['relationships'] }

  describe '#index' do
    before { get(occupiables_path, headers: headers) }

    it do
      expect(response).to be_ok
      expect(response.content_type).to eq('application/vnd.api+json')
    end
  end

  describe '#show' do
    before { get(occupiables_path(occupiable.to_param), headers: headers) }

    it do
      expect(response).to be_ok
      expect(response.content_type).to eq('application/vnd.api+json')
    end
  end

  describe '#show/occupancies' do
    let!(:occupancies) { create_list(:reservation, 3, occupiable: occupiable) }
    before { get(occupiables_path(occupiable.to_param, :occupancies), headers: headers) }

    it do
      expect(response).to be_ok
      expect(response.content_type).to eq('application/vnd.api+json')
      expect(data.count).to be(occupancies.count)
    end
  end
end
