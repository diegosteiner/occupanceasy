# frozen_string_literal: true
require 'rails_helper'

describe Booking, type: :model do
  let(:booking) { create(:booking) }
  let(:home) { create(:home) }

  describe 'attributes' do
    it do
      expect(booking.occupiable).to be_instance_of(Occupiable)
      expect(booking.contact_email).not_to be_empty
    end
  end

  describe 'factory' do
    it do
      booking = create(:booking)
      expect(booking).to be_valid
      expect(booking.save).to eq(true)
    end
  end

  describe 'validations' do
    it do
      booking = Occupancy.new
      expect(booking).not_to be_valid
      booking.occupiable = create(:home)
      booking.begins_at = 1.week.from_now
      expect(booking).not_to be_valid
      booking.ends_at = 1.day.from_now
      expect(booking).not_to be_valid
      booking.ends_at = 2.weeks.from_now
      expect(booking).to be_valid
      expect(booking.save).to eq(true)
    end
  end

  describe '#range' do
    it do
      expect(booking.range.begin).to eq(booking.begins_at)
      expect(booking.range.end).to eq(booking.ends_at)
    end
  end

  describe 'scope :overlapping' do
    subject { Booking.overlapping(booking.range).map(&:id) }
    it { is_expected.to eq([booking.id]) }
  end
end
