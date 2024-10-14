
The Data Marketplace
====================

This repository stores objects (JSON Schema) that are used to define the structure of objects passed to and from the Data
Marketplace and the API specification for the interface through which the objects will be transported.

JSON Schema
-----------

A JSON Schema provides a computer readable description of a metadata data object. The project’s schema can be compared to a JSON
representation of a Data Marketplace resource’s metadata with the output being a report describing the discrepancies between the
two. This allows the schema to be used to validate metadata records.

Due to the straightforward structure of JSON the description can also be read by people such that it is also a useful tool to aid
discussion around the construction of metadata objects.

JSON Schema is a widely used protocol which means there are many tools that allow it to be used in a wide variety of programming
environments. There are also a large number of tools that allow objects defined using other protocols to be compared to the schema;
for example XML.

The Project’s JSON Schema are stored at /schema


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

Data Marketplace objects described by the schema
------------------------------------------------

There are three main types of objects described by the project JSON schema.

- Core objects: describe the primary objects that need to be described within the marketplace catalogue.
- Shared objects: contain structures that are shared across core objects
- Supporting object: are objects that are useful in systems working with the core objects

### Core objects

#### Dataset

The metadata representation of a data object. The object could be a spreadsheet, a database, or even a part of a database
(a query result for example). Typically within the Data Marketplace an ESDA record is represented as a Dataset.

#### Data Service

The service that returns data. That could be an API, a file system, or any data storage or delivery system. The data
returned could range from simple Yes/No boolean responses to gigabytes of structured data.

#### Data Share

The data gathered in support of a data share request.

### Shared objects

#### Catalogued Resource

The core objects share a common root structure. That is, there are a number of fields that are contained within each of
the core objects. Rather than repeating the defining schema for these common fields in each of the core object schema,
these field descriptions are defined once in the Catalogued Resource. Then each core object schema refers to this common
schema.

The effect of this is that Dataset, Data Service, and Data Share objects will each contain all the fields described in
the Catalogued Resource, as well as the fields specific to themselves.

Currently there is no use case for a catalogued resource object to be used directly and in isolation. All catalogued
resources will be defined via the core objects: Dataset, Data Service, and Data Share. Note also that the Data Group
also shares the Catalogued Resource fields.

#### Shared schema
Some object definitions are more complicated than standard and are used in multiple places. The prime example of this
is the date stamp where a number of formats are supported. The shared schema is used as a place to define these object
descriptions. These descriptions are then referenced within the other object schema.

### Support objects

#### Data Group

There are a number of use cases where it would be useful to group a number of core objects together. For example,
if annual examination results were presented as a Dataset for each year, it would be convenient to be able to refer to
all the examination datasets within a period via a single group object.

The main purpose of the Data Group is as a container for references (ids or locations)  for the objects within the group.

The Data Group shares the common structure of the core objects and is a type of catalogued resource. Therefore it contains
the fields defined in the catalogued resource schema in addition to the fields defined in its own schema.

As the Data Group shares the same basic structure as the core objects, it can be used as a replacement to one of those
objects within the systems using them. This facilitates actions such as a search for metadata concerning “exam results”
returning both individual metadata records and groups of matching records.

#### Error object

The schema also contains a definition of an object that will contain information about an error that has occurred while
moving or processing Data Marketplace data objects.

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

The API Specification
---------------------

The basic purpose of the API is to provide access to the metadata records by systems outside the Data Marketplace. To
achieve this the outside system (remote) sends a request  via HTTP (the internet’s standard transport protocol) to an
endpoint location (an URL) provided by the Data Marketplace. The characteristics of the request determine the response
and the API specification defines the relationship between the request and the expected response.

The Project’s API Specification is stored at /api_specification

### API Actions

There are four standard actions that API support. These are commonly referred to as the
[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) actions:

- Create - used to create a new record.
- Read - where a record is viewed only.
- Update - used to modify a record that already exists within the system being accessed.
- Delete - removes the record from the system being accessed

These four actions cover most use cases for remote access of data via an API.

### REST

REST (Representational State Transfer) is a software architectural style that was created to guide the design and
development of the architecture for the World Wide Web. The REST architectural style emphasises uniform interfaces,
independent deployment of components, the scalability of interactions between them, and creating a layered architecture
to promote caching to reduce user-perceived latency, enforce security, and encapsulate legacy systems.

In a REST system, records are usually referred to as resources.

For a resource to be managed via a REST system each CRUD action applied to the resource should have a unique endpoint.
To achieve this efficiently the endpoint is constructed from three components:

- The system’s root URL
- A path to a CRUD endpoint with a matching HTTP method
- A modification to the path that uniquely identifies the resource (if the resource exists)

For the second element it is typical to match the HTTP methods POST, GET, PATCH, DELETE to the respective CRUD actions
of Create, Read, Update, and Delete.

So if an API at `http://example.com` made available a collection of Things, it would be typical to create the following
set of endpoints:

- **POST to `http://example.com/things`** - Create a new resource. The response to this action would include the ID of the
  newly created “thing” resource.
- **GET `http://example.com/things`** - Read all: a list of things including the URLs to read each individual thing (see next
  item)
- **GET `http://example.com/things/<ID>`** - Read one: where “<ID>” would be replaced with the ID of the matching “thing” to
  be viewed.
- **PATCH  `http://example.com/things/<ID>`** - Update one: Update the resource with the matching ID.
- **DELETE  `http://example.com/things/<ID>`** - Delete one: The resource with the matching ID would be removed from the system.

### OpenAPI

The [OpenAPI Specification (OAS)](https://spec.openapis.org/oas/latest.html) defines a standard, programming
language-agnostic interface description for HTTP APIs, which allows both humans and computers to discover and understand
the capabilities of a service without requiring access to source code, additional documentation, or inspection of network
traffic. When properly defined via OpenAPI, a consumer can understand and interact with the remote service with a minimal
amount of implementation logic. Similar to what interface descriptions have done for lower-level programming, the OpenAPI
Specification removes guesswork in calling a service.

The API specification defined at /api_specification in this repository is define using the OpenAPI specification.

### Swagger UI

[Swagger](https://swagger.io) started out as a simple, open source specification for designing RESTful APIs in 2010. Open
source tooling like the Swagger UI, Swagger Editor and the Swagger Codegen were also developed to better implement and
visualize APIs defined in the specification. The Swagger project, consisting of the specification and the open source tools,
became immensely popular, creating a massive ecosystem of community driven tools.

In 2015, the Swagger project was acquired by SmartBear Software. The Swagger Specification was donated to the Linux
foundation and renamed the OpenAPI.

[Swagger UI](https://swagger.io/tools/swagger-ui/) is an Open Source tool that allows anyone — be it your development
team or your end consumers — to visualize and interact with the API’s resources without having any of the implementation
logic in place. It’s automatically generated from your OpenAPI (formerly known as Swagger) Specification, with the visual
documentation making it easy for back end implementation and client side consumption.

A Swagger UI representation of the API Specification can be found at
[/swagger](https://co-cddo.github.io/demo-data-marketplace-metadata-json-schema/swagger/)
on this repositories Github pages.

Running locally
---------------

A Ruby script is provided that loads the project JSON Schema and sample JSON objects, and attempts to validate the
objects against the schema.

To use the script (assuming Ruby is installed locally) first run `bundle` to install the dependencies, and then run
the script using:

```bash
ruby schema_test.rb
```
