# frozen_string_literal: true

require 'simplecov'

SimpleCov.minimum_coverage 100
SimpleCov.start 'rails' do
  add_group 'Serializers', 'app/serializers'
  add_filter '/app/controllers/api/v1/manage/'
end
