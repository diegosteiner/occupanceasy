# frozen_string_literal: true
require 'rails_helper'

describe Occupancy, type: :model do
  let(:occupancy) { create(:reservation) }
  let(:home) { create(:home) }

  describe 'attributes' do
    it do
      expect(occupancy.occupiable).to be_instance_of(Occupiable)
      expect(occupancy.contact_email).not_to be_empty
    end
  end

  describe 'factory' do
    it do
      occupancy = create(:reservation)
      expect(occupancy).to be_valid
      expect(occupancy.save).to eq(true)
    end
  end

  describe '#range' do
    it do
      expect(occupancy.range.begin).to eq(occupancy.begins_at)
      expect(occupancy.range.end).to eq(occupancy.ends_at)
    end
  end

  describe 'scope :overlapping' do
    context 'with overlapping occupancies' do
      let!(:reservation_request) do
        create(:reservation_request, occupiable: home, begins_at: occupancy.begins_at, ends_at: occupancy.ends_at)
      end
      subject { Occupancy.overlapping(occupancy.range).map(&:id) }
      it { is_expected.to eq([occupancy.id]) }
    end
  end

  describe '#conflicting' do
    it do
      occupancy = create(:reservation, occupiable: home)
      conflicting = create(:reservation, occupiable: home)
      expect(occupancy.conflicting.map(&:id)).to eq([conflicting.id])
    end
  end
end
