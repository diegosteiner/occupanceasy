# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

gem 'active_model_serializers', '~> 0.10.0'
gem 'figaro'
gem 'paper_trail', '~> 6.0'
gem 'pg'
gem 'rails', '~> 5.0'

group :production do
  gem 'lograge'
  gem 'puma', '~> 3.0'
  gem 'rack-timeout'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails', require: false
  gem 'json_schema'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'listen', '> 3.0.5'
  gem 'spring'
  gem 'thin'
end

group :lint do
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'simplecov', require: false
end
