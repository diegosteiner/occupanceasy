require 'test_helper'

class OccupancyTest < ActiveSupport::TestCase
  test 'has all attributes' do
    occupancy = occupancies(:reservation)
    assert_instance_of(Occupiable, occupancy.occupiable)
    assert_not_predicate(occupancy.contact_email, :empty?)
  end

  test 'can create a valid occupancy' do
    occupancy = Occupancy.new
    assert_not_predicate(occupancy, :valid?)
    occupancy.occupiable = occupiables(:home)
    occupancy.begins_at = 1.week.from_now
    assert_not_predicate(occupancy, :valid?)
    occupancy.ends_at = 1.day.from_now
    assert_not_predicate(occupancy, :valid?)
    occupancy.ends_at = 2.weeks.from_now
    assert_predicate(occupancy, :valid?)
    assert(occupancy.save)
    assert_predicate(occupancy, :reservation?)
  end

  test '#span' do
    occupancy = occupancies(:reservation)
    assert_equal(occupancy.begins_at, occupancy.range.begin)
    assert_equal(occupancy.ends_at, occupancy.range.end)
  end

  test 'scope :overlapping' do
    occupancy = occupancies(:reservation)
    assert_equal([occupancy.id], Occupancy.overlapping(occupancy.range).map(&:id))
  end

  test '#conflicting' do
    occupancy = occupancies(:overlapping_1)
    conflicting = occupancies(:overlapping_2)
    assert_equal(occupancy.conflicting.map(&:id), [conflicting.id])
    occupancy = occupancies(:reservation)
    assert_not_predicate(occupancy.conflicting, :any?)
  end
end
