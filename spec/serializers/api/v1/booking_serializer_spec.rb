# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::BookingSerializer do
  let(:booking) { create(:reservation) }
  let(:serializer) { described_class.new(booking) }

  describe 'serialization' do
    let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
    let(:json) { serialization.to_json }
    subject(:parsed_json) { JSON.parse(json) }

    it { is_expected.to have_key('data') }
  end
end
