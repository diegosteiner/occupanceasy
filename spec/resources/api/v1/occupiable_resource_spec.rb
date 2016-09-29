# frozen_string_literal: true
require 'rails_helper'

describe OccupiableSerializer do
  let(:occupiable) { create(:home) }
  let(:serializer) { described_class.new(occupiable) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:json) { serialization.to_json }
  subject(:parsed_json) { JSON.parse(json) }

  it { is_expected.to have_key('data') }

  describe '["data"]' do
    subject(:data) { parsed_json['data'] }
    it { is_expected.to have_key('attributes') }
    it do
      is_expected.to include(
        'id' => occupiable.id,
        'type' => 'occupiables'
      )
    end

    describe '["attributes"]' do
      subject(:attributes) { data['attributes'] }
      it do
        is_expected.to include(
          'description' => occupiable.description
        )
      end
    end
  end
end
