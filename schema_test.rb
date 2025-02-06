# frozen_string_literal: true

require 'json-schema'
require 'json'

def json_from(path)
  JSON.parse(File.read(path))
end

def validate(sample:, schema:)
  puts sample
  puts schema
  result = begin
    JSON::Validator.validate!(json_from(schema), json_from(sample))
  rescue JSON::Schema::ValidationError => e
    e.message
  end
  puts "RESULT: #{result}"
  puts "-------------------\n"
end

validate(
  sample: 'samples/unified.json',
  schema: 'schema/unified_schema.json'
)


validate(
  sample: 'samples/dataset.json',
  schema: 'schema/catalogued_resource_schema.json'
)

validate(
  sample: 'samples/data_service.json',
  schema: 'schema/catalogued_resource_schema.json'
)

validate(
  sample: 'samples/dataset.json',
  schema: 'schema/dataset_schema.json'
)

validate(
  sample: 'samples/data_service.json',
  schema: 'schema/data_service_schema.json'
)

validate(
  sample: 'samples/data_group.json',
  schema: 'schema/data_group_schema.json'
)

validate(
  sample: 'samples/data_share.json',
  schema: 'schema/data_share_schema.json'
)

validate(
  sample: 'samples/error.json',
  schema: 'schema/error_schema.json'
)
