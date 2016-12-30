source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

gem 'rails', '~> 5.0'
gem 'pg'
gem 'figaro'
gem 'active_model_serializers', '~> 0.10.0'
gem 'paper_trail'

group :production do
  gem 'lograge'
  gem 'puma', '~> 3.0'
  gem 'rack-timeout'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'factory_girl_rails', require: false
  gem 'rspec-rails', '~> 3.5'
  gem 'byebug'
  gem 'pry-rails'
  gem 'spring-commands-rspec'
  gem 'json_schema'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'thin'
end

group :lint do
  gem 'simplecov', require: false
  gem 'brakeman', require: false
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'bundler-audit', require: false
end
