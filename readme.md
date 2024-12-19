
Data Catalogue Metadata
=======================

This repository stores objects (JSON Schema) that are used to define the structure of objects passed to and from Data Catalogues
such as the Data Marketplace and the API specification for the interface through which the objects will be transported.

JSON Schema
-----------

A JSON Schema provides a computer readable description of a metadata data object. The project’s schema can be compared to a JSON
representation of a Data Catalogue's resource’s metadata with the output being a report describing the discrepancies between the
two. This allows the schema to be used to validate metadata records.

Due to the straightforward structure of JSON the description can also be read by people such that it is also a useful tool to aid
discussion around the construction of metadata objects.

JSON Schema is a widely used protocol which means there are many tools that allow it to be used in a wide variety of programming
environments. There are also a large number of tools that allow objects defined using other protocols to be compared to the schema;
for example XML.

The JSON Schema descriptions and links to individual files can be found at
[/schema](https://co-cddo.github.io/data-catalogue-metadata/schema)


The API Specification
---------------------

The basic purpose of the API is to provide access to the metadata records by systems outside the Data Marketplace. To
achieve this the outside system (remote) sends a request  via HTTP (the internet’s standard transport protocol) to an
endpoint location (an URL) provided by the Data Marketplace. The characteristics of the request determine the response
and the API specification defines the relationship between the request and the expected response.

The Data Marketplace API Specification is stored at /api_specification

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
- **GET `http://example.com/things/<ID>`** - Read one: where “`<ID>`” would be replaced with the ID of the matching “thing” to
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
[/swagger](https://co-cddo.github.io/data-catalogue-metadata/swagger/)
on this repositories Github pages.

#### Bundling the API specification into a single file

The API Specification uses references to the JSON schema files for definitions of most object. If you need to have
the specification represented in a single file without references to other files, the Swagger CLI bundle
command can be used to do this.

For example:

Assuming [Node](https://nodejs.org) is installed locally, Swagger CLI can be installed with:

```
npm install -g @apidevtools/swagger-cli
```

Then the following command run at the root of this app, will build a new api configuration at `api_specification/bundled_metadata_management_api.yaml`

```
swagger-cli bundle -o api_specification/bundled_metadata_management_api.yaml api_specification/metadata_management_api.yaml
```
