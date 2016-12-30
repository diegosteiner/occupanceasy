# frozen_string_literal: true
require 'rails_helper'
require 'json_schema'

describe Api::V1::BookingSerializer do
  let(:booking) { create(:reservation) }
  let(:serializer) { described_class.new(booking) }

  describe 'serialization' do
    let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
    let(:json) { serialization.to_json }
    subject(:parsed_json) { JSON.parse(json) }

    it { is_expected.to have_key('data') }

    describe 'schema' do
      let(:schema) { JsonSchema.parse!(JSON.parse(File.read('spec/support/schema/api/v1/bookings.json'))) }
      it 'is valid' do
        expect(schema.validate(parsed_json)).to eq([true, []])
      end
    end
  end
end
