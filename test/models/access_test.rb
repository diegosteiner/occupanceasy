# frozen_string_literal: true
require 'test_helper'

class AccessTest < ActiveSupport::TestCase
  test 'has all attributes' do
    access = create(:access)
    assert_instance_of(Access, access)
    assert_operator(64, :<, access.private_key.size)
    assert_not_predicate(access.description, :empty?)
  end

  test 'new instance has private_key' do
    access = Access.new(description: 'new access')
    assert(access.save)
    assert_operator(64, :<, access.private_key.size)
  end
end
