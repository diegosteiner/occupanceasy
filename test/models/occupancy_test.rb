# frozen_string_literal: true
require 'test_helper'

describe Occupancy do
  let(:occupancy) { create(:reservation) }
  let(:home) { create(:home) }
  describe 'attributes' do
    it do
      occupancy.occupiable.must_be_instance_of(Occupiable)
      occupancy.contact_email.wont_be(:empty?)
    end
  end

  describe 'factory' do
    it do
      occupancy = create(:reservation)
      occupancy.must_be(:valid?)
      occupancy.save.must_equal(true)
    end
  end

  describe 'validations' do
    it do
      occupancy = Occupancy.new
      occupancy.wont_be(:valid?)
      occupancy.occupiable = create(:home)
      occupancy.begins_at = 1.week.from_now
      occupancy.wont_be(:valid?)
      occupancy.ends_at = 1.day.from_now
      occupancy.wont_be(:valid?)
      occupancy.ends_at = 2.weeks.from_now
      occupancy.must_be(:valid?)
      occupancy.save.must_equal(true)
    end
  end

  describe '#range' do
    it do
      occupancy.range.begin.must_equal(occupancy.begins_at)
      occupancy.range.end.must_equal(occupancy.ends_at)
    end
  end

  describe 'scope :overlapping' do
    it do
      Occupancy.overlapping(occupancy.range).map(&:id).must_equal([occupancy.id])
    end
  end

  describe '#conflicting' do
    it do
      occupancy = create(:reservation, occupiable: home)
      conflicting = create(:reservation, occupiable: home)
      occupancy.conflicting.map(&:id).must_equal([conflicting.id])
    end
  end
end
