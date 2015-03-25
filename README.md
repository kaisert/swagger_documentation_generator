# Swagger for Eiffel Documentation

## Introduction
This gives a n overview about how to use this Eiffel library in order to produce Swagger documentation from Eiffel annotations. The same terminology as in [the official specificaions](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md) will be used.

## Getting started
Add the library swagger_documentation_generation to your project. Create an object of type SWAGGER_DOC_GENERATOR and call create_documentation on it. Pass the location of your project as the argument. The generator will produce a file called swagger.json. Use this file to create the swagger documentation.

## Using Annotations to create Swagger Documentation
Use the note section of an Eiffel class or feature to create annotations. Annotations are always of the form 
```Eiffel
note
  annotation_tag: "value", 1, 1.0, true
```
whereas for the swagger documentation only values of type string are being accepted. To create a swagger documentation, a few objects are mandatory (N.B https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md). This guide will lead you step by step through how to successfully write Eiffel annotations to create a swagger documentation. 

### Swagger Object
This is the main object. To create this using Eiffel annotations, one must specify its values in the note section of_one_ class.

```Eiffel
note
  sa_spec: "swagger=2.0", "host=www.domain.com", "base_path=/basePath"
```
whereas the 'swagger' is mandatory and host and base_path can be omitted
Further the info object must be initialized:

```Eiffel
note
  sa_spec: "swagger=2.0", "host=www.domain.com", "base_path=/basePath"
  
  sa_info: "version=1.0.0", "title=my application", "description=my description", "terms_of_service=my terms of service"
```
following fields are mandatory for the info sa_info tag: version, title. Additionally contact and license information can be declared by 

```Eiffel
note
  sa_spec: "swagger=2.0", "host=www.domain.com", "base_path=/basePath"
  
  sa_info: "version=1.0.0", "title=my application", "description=my description", "terms_of_service=my terms of service"
sa_contact: "name=API Support", "url=http://www.swagger.io/support", "email=support@swagger.io"
sa_license: "name=Apache 2.0", "url=http://www.apache.org/licenses/LICENSE-2.0.html"
```
details about the specific fields of contact and licence can be taken from the official specifications ([conact object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#contactObject),[licence object]( https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#licenseObject))

The sa_spec and the sa_info annotation is the absolute minimum to define a swagger documentation. Without these parameters and their required fields no JSON file can be generated.


