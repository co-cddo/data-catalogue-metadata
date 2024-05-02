Data Marketplace JSON Schema
============================

The repository contains a JSON schema that can be used to validata metadata records submitted to the Data Marketplace

Running locally
---------------

The schema is defined at data_marketplace_schema.json

A Ruby script is provided that loads the schema and a sample JSON object, and attempts to validate the object against the schema.

To use the script, first run `bundle` to install the dependencies, and then run the script using:

```ruby
ruby schema_test.rb
```
