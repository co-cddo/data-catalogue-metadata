require "json-schema"
require "json"

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
  sample: 'samples/sample_data_service.json',
  schema: 'schema/data_marketplace_data_service_schema.json'
)

validate(
  sample: 'samples/are_you_eligible.json',
  schema: 'schema/data_marketplace_data_service_schema.json'
)

validate(
  sample: 'samples/are_you_eligible_by_reference.json',
  schema: 'schema/data_marketplace_data_service_schema.json'
)

validate(
  sample: 'samples/exam_results.json',
  schema: 'schema/data_marketplace_data_service_schema.json'
)

validate(
  sample: 'samples/spreadsheet.json',
  schema: 'schema/data_marketplace_dataset_schema.json'
)

validate(
  sample: 'samples/sample_core.json',
  schema: 'schema/data_marketplace_dataset_schema.json'
)

validate(
  sample: 'samples/sample_distribution.json',
  schema: 'schema/data_marketplace_dataset_schema.json'
)

validate(
  sample: 'samples/group_of_datasets.json',
  schema: 'schema/data_marketplace_resource_group_schema.json'
)

validate(
  sample: 'samples/group_of_dataset_references.json',
  schema: 'schema/data_marketplace_resource_group_schema.json'
)

validate(
  sample: 'samples/error.json',
  schema: 'schema/data_marketplace_error_schema.json'
)
