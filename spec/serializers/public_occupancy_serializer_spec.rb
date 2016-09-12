# frozen_string_literal: true
require 'rails_helper'

describe PublicOccupancySerializer do
  let(:occupancy) { create(:reservation) }
  let(:serializer) { described_class.new(occupancy) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { serialization.to_json }
  subject(:parsed_json) { JSON.parse(json) }

  it { is_expected.to have_key('data') }

  describe '["data"]' do
    subject(:data) { parsed_json['data'] }
    it { is_expected.to have_key('attributes') }
    it { is_expected.to have_key('relationships') }
    it do
      is_expected.to include(
        'id' => occupancy.id,
        'type' => 'reservations'
      )
    end

    describe '["attributes"]' do
      subject(:attributes) { data['attributes'] }
      it do
        is_expected.to include(
          'begins_at' => occupancy.begins_at.iso8601(3),
          'ends_at' => occupancy.ends_at.iso8601(3)
        )
      end
    end

    describe '["relationships"]' do
      subject(:relationships) { data['relationships'] }
      it { is_expected.to have_key('occupiable') }
    end
  end
end
