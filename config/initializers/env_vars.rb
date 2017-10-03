# frozen_string_literal: true

require 'yaml'
defaults = YAML.load_file(Rails.root.join('config/defaults.yml'))
Figaro.require_keys(*defaults.fetch(Rails.env, {}).keys)
