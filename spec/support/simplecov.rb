# frozen_string_literal: true
require 'simplecov'

SimpleCov.minimum_coverage 100
SimpleCov.start 'rails' do
  add_group 'Resources', 'app/resources'
end
