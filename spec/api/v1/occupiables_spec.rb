# frozen_string_literal: true
require 'rails_helper'

BASE_PATH = '/api/v1'
def headers
  {
    'HTTP_ACCEPT' => 'application/vnd.api+json'
  }
end

def parsed_json; subject; JSON.parse(response.body); end
def data; parsed_json['data']; end
def data_ids; data.map { |item| item['id'] }; end;
def relationsships; data['relationships']; end

def occupiables_path(id = nil, relationships = nil, params = {})
  path = String.new('/api/v1/occupiables')
  path << '/' << id.to_s if id.present?
  path << '/' << relationships.to_s if relationships.present?
  path << '?' << params.map { |key, value| "#{key}=#{value}" }.join('&') if params.present?
  path
end

shared_examples 'valid response' do
  it  do
    expect(subject)
    expect(response).to be_ok
    expect(response.content_type).to eq('application/vnd.api+json')
  end
end

shared_examples 'valid bookings' do
  it { expect(data_ids).to contain_exactly(*bookings.map(&:id)) }
end

describe Api::V1::OccupiablesController, type: :request do
  let(:occupiable) { create(:home) }
  let(:params) { {} }

  describe '#index' do
    subject { get(occupiables_path, headers: headers) }

    it_behaves_like 'valid response'
  end

  describe '#show' do
    subject { get(occupiables_path(occupiable.to_param), headers: headers) }

    it_behaves_like 'valid response'
  end

  describe '#show/bookings' do
    subject { get(occupiables_path(occupiable.to_param, :bookings, params), headers: headers) }
    let!(:bookings) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.weeks.from_now) }

    it_behaves_like 'valid response'
    it { expect(data.count).to be(bookings.count) }

    describe 'filter' do

      describe 'begins_after' do
        let!(:bookings_out_of_range) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.months.ago) }
        let(:params) { { 'filter[begins_after]' => Time.zone.now.beginning_of_month.iso8601 } }

        it_behaves_like 'valid response'
        it_behaves_like 'valid bookings'
      end

      describe 'ends_before' do
        let!(:bookings_out_of_range) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 3.months.from_now) }
        let(:params) { { 'filter[ends_before]' => 1.month.from_now.end_of_month.iso8601 } }

        it_behaves_like 'valid response'
        it_behaves_like 'valid bookings'
      end

      describe 'defaults' do
        let!(:bookings_out_of_range) do 
          [
            create(:reservation, occupiable: occupiable, begins_at: 3.months.ago),
            create(:reservation, occupiable: occupiable, begins_at: 3.years.from_now)
          ]
        end
        let!(:bookings) { create_list(:reservation, 2, occupiable: occupiable, begins_at: 1.weeks.from_now) }

        it_behaves_like 'valid response'
        it_behaves_like 'valid bookings'
      end
    end
  end
end
