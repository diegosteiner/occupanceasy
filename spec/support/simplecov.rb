# frozen_string_literal: true
require 'simplecov'

SimpleCov.minimum_coverage 100
SimpleCov.command_name 'Rspec'
SimpleCov.start 'rails' do
  add_group 'Resources', 'app/resources'
end
