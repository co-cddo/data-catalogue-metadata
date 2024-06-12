Data Marketplace JSON Schema
============================

The repository contains a JSON schema that can be used to validata metadata records submitted to the Data Marketplace

Running locally
---------------

The schema are defined in /schema

A Ruby script is provided that loads the schema and a sample JSON objects, and attempts to validate the objects against the schema.

To use the script, first run `bundle` to install the dependencies, and then run the script using:

```ruby
ruby schema_test.rb
```
