# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::BookingResource do
  let(:booking) { create(:reservation) }
  let(:context) { nil }

  describe 'serialization' do
    let(:serializer) { JSONAPI::ResourceSerializer.new(described_class) }
    let(:resource) { described_class.new(booking, context) }
    subject { serializer.serialize_to_hash(resource) }

    describe 'data' do
      let(:data) { subject[:data] }

      describe 'attributes' do
        let(:attributes) { data['attributes'] }
        let(:expected_attributes) do
          {
            begins_at: booking.begins_at,
            ends_at: booking.ends_at,
            booking_type: booking.type,
            blocking: booking.blocking
          }.stringify_keys
        end

        it { expect(attributes).to include(expected_attributes) }
      end
    end
  end
end
