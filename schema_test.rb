require "json-schema"
require "json"

sample = JSON.parse(File.read('sample.json'))
schema = JSON.parse(File.read('data_marketplace_schema.json'))

puts begin
  JSON::Validator.validate!(schema, sample)
rescue JSON::Schema::ValidationError => e
  e.message
end
