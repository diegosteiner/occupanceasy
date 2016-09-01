# frozen_string_literal: true
require 'test_helper'

class OccupiableTest < ActiveSupport::TestCase
  test 'has all attributes' do
    occupiable = occupiables(:home)
    assert_instance_of(Occupiable, occupiable)
    assert_instance_of(Access, occupiable.access)
    assert_not_predicate(occupiable.description, :empty?)
  end
end
