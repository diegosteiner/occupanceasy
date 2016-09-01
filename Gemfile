source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

gem 'rails', '~> 5.0'
gem 'pg'
gem 'active_model_serializers', '>= 0.10.0.rc4'
gem 'figaro'

group :test do
  #gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :production do
  gem 'lograge'
  gem 'puma', '~> 3.0'
  gem 'rack-timeout'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'factory_girl_rails', require: false
  gem 'faker', require: false
  gem 'byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'bundler-audit', require: false
  #gem 'spring-commands-rspec'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'thin'
end
