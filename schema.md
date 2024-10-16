Data Catalogue objects described by the schema
==============================================

There are three main types of objects described by the project JSON schema.

- Core objects: describe the primary objects that need to be described within the data catalogue.
- Shared objects: contain structures that are shared across core objects
- Supporting object: are objects that are useful in systems working with the core objects

Core objects
------------

### Dataset

[schema/dataset_schema.json](https://co-cddo.github.io/data-catalogue-metadata/schema/dataset_schema.json)

The metadata representation of a data object. The object could be a spreadsheet, a database, or even a part of a database
(a query result for example). Typically an
[ESDA](https://www.gov.uk/government/publications/essential-shared-data-assets-and-data-ownership-in-government/essential-shared-data-assets-esdas-policy-html) record is represented as a Dataset.

### Data Service

[schema/data_service_schema.json](https://co-cddo.github.io/data-catalogue-metadata/schema/data_service_schema.json)

The service that returns data. That could be an API, a file system, or any data storage or delivery system. The data
returned could range from simple Yes/No boolean responses to gigabytes of structured data.

### Data Share

[schema/data_share_schema.json](https://co-cddo.github.io/data-catalogue-metadata/schema/data_share_schema.json)

The data gathered in support of a data share request.

Shared objects
--------------

### Catalogued Resource

[schema/catalogued_resource_schema.json](https://co-cddo.github.io/data-catalogue-metadata/schema/catalogued_resource_schema.json)

The core objects share a common root structure. That is, there are a number of fields that are contained within each of
the core objects. Rather than repeating the defining schema for these common fields in each of the core object schema,
these field descriptions are defined once in the Catalogued Resource. Then each core object schema refers to this common
schema.

The effect of this is that Dataset, Data Service, and Data Share objects will each contain all the fields described in
the Catalogued Resource, as well as the fields specific to themselves.

### Shared schema

[schema/shared_schema.json](https://co-cddo.github.io/data-catalogue-metadata/schema/shared_schema.json)

Some object definitions are more complicated than standard and are used in multiple places. The prime example of this
is the date stamp where a number of formats are supported. The shared schema is used as a place to define these object
descriptions. These descriptions are then referenced within the other object schema.

Support objects
---------------

### Data Group

[schema/data_group_schema.json](https://co-cddo.github.io/data-catalogue-metadata/schema/data_group_schema.json)

There are a number of use cases where it would be useful to group a number of core objects together. For example,
if annual examination results were presented as a Dataset for each year, it would be convenient to be able to refer to
all the examination datasets within a period via a single group object.

The main purpose of the Data Group is as a container for references (ids or locations)  for the objects within the group.

The Data Group shares the common structure of the core objects and is a type of catalogued resource. Therefore it contains
the fields defined in the catalogued resource schema in addition to the fields defined in its own schema.

As the Data Group shares the same basic structure as the core objects, it can be used as a replacement to one of those
objects within the systems using them. This facilitates actions such as a search for metadata concerning “exam results”
returning both individual metadata records and groups of matching records.

### Error object

[schema/error_schema.json](https://co-cddo.github.io/data-catalogue-metadata/schema/error_schema.json)


The schema also contains a definition of an object that will contain information about an error that has occurred while
moving or processing Data Catalogue objects.

This is an example of an error object:
```json
{
  "message": "Validation failure",
  "code": "401",
  "errors": [
    {
      "type": "http://example.com/docs/errors/exceeded-max-length",
      "detail": "The attribute 'summary' is too long. It should be less than 250 characters",
      "instance": "identifier:f58ce342-d3cc-4a13-bba4-ac958c39397b",
      "location": "/summary",
      "severity": "minor"
    }
  ]
}
```

Information about JSON and JSON Schema
--------------------------------------

### JSON

[JavaScript Object Notation (JSON)](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON) is a standard text-based
format for representing structured data based on JavaScript object syntax. It is commonly used for transmitting data in web
applications (for example, sending some data from the server to the client, so it can be displayed on a web page, or vice versa).

JSON has been chosen as the default format for describing the Data Marketplace metadata models because of its simple structure (it
is basically just a text representation of key/value pairs) and ability to represent nested structures (where a value is itself
another JSON object or array).

For example, this is a JSON representation of Dataset metadata that could have been submitted via an ESDA template spreadsheet:
```json
{
  "identifier": "8d085327-21b6-4d8b-9705-88faad231d22",
  "supplierIdentifier": "acme-123",
  "modified": "2023-12-09T16:09:53+00:00",
  "status": "Published",
  "title": "Advance Passenger Information",
  "description": "Travel data and personal data given to airlines by passenger.",
  "type": "Data Set",
  "theme": [
    "Transport and infrastructure",
    "Population and society"
  ],
  "keyword": [
    "Air travel",
    "Passport",
    "Airports",
    "leaving UK",
    "entering UK"
  ],
  "contactPoint": [
    {
      "name": "Jane Doe",
      "email": "jane.doe@example.com"
    }
  ],
  "publisher": "academy-for-social-justice",
  "securityClassification": "OFFICIAL",
  "accessRights": "INTERNAL",
  "distribution": [
    {
      "accessService": ["8d085327-21b6-4d8b-9705-88faad231d23"],
      "downloadURL": "http://example.com/path/to/file.csv",
      "mediaType":["text/csv"]
    }
  ]
}
```

One of the key advantages of the JSON description of the data over the spreadsheet description is the better support for nesting.
For example, if a second contactPoint is required another object can be added to the contactPoint array:
```json
"contactPoint": [
  {
    "name": "Jane Doe",
    "email": "jane.doe@example.com"
  },
  {
    "name": "Fred Bloggs",
    "email": "fred.bloggs@example.com"
  }
],
```
Within a spreadsheet either a separate sheet, or additional fields would need to be added (for example, extra fields
contactPointName2 and contactPointEmail2).

In the past the spreadsheet representation of the data has made it difficult to do things like define multiple distribution
formats for a single dataset. As with the contactPoint example above, in the JSON description it is straightforward to add
additional distribution objects:
```json
"distribution": [
    {
      "accessService": ["8d085327-21b6-4d8b-9705-88faad231d23"],
      "downloadURL": "http://example.com/path/to/file.csv",
      "mediaType":["text/csv"]
    },
    {
      "accessService": ["8d085327-21b6-4d8b-9705-88faad231d23"],
      "downloadURL": "http://example.com/path/to/file.json",
      "mediaType":["application/json"]
    },
    {
      "accessService": ["8d085327-21b6-4d8b-9705-88faad231d23"],
      "downloadURL": "http://example.com/path/to/file.xml",
      "mediaType":["text/xml"]
    }
  ]
```

### JSON Schema

[JSON Schema](https://json-schema.org/) is the vocabulary that enables JSON data consistency, validity, and interoperability
at scale. Each schema is itself defined by a JSON object with the vocabulary defining the necessary structure of the object.

This is a simple JSON Schema that describes the structure of a Person JSON object:
```json
{
  "$id": "https://example.com/person.schema.json",
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Person",
  "type": "object",
  "properties": {
    "firstName": {
      "type": "string",
      "description": "The person's first name."
    },
    "lastName": {
      "type": "string",
      "description": "The person's last name."
    },
    "age": {
      "description": "Age in years which must be equal to or greater than zero.",
      "type": "integer",
      "minimum": 0
    }
  }
}
```

The schema defines an object with the title “Person”, that has three properties: firstName, lastName, and age. The two name
properties should have string values, while age will be an integer. Age has a further restriction in that it cannot be less than
zero.

Here is a person object that matches that schema:

```json
{
  "firstName": "John",
  "lastName": "Doe",
  "age": 21
}
```

Running the JSON schema locally
-------------------------------

A Ruby script is provided that loads the project JSON Schema and sample JSON objects, and attempts to validate the
objects against the schema.

To use the script (assuming Ruby is installed locally) first run `bundle` to install the dependencies, and then run
the script using:

```bash
ruby schema_test.rb
```
