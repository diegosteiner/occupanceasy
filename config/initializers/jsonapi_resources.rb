# frozen_string_literal: true
JSONAPI.configure do |config|
  # Allowed values are :integer(default), :uuid, :string, or a proc
  config.resource_key_type = :uuid
  config.json_key_format = :underscored_key
  config.top_level_meta_include_record_count = true
end
