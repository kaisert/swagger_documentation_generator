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
details about the specific fields of contact and licence can be taken from the official specifications ([conact object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#contactObject), [licence object]( https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#licenseObject))

The sa_spec and the sa_info annotation is the absolute minimum to define a swagger documentation. Without these parameters and their required fields no JSON file can be generated.
Furthermore, the optional object of the swagger object are created as follows:

```Eiffel
note 
  sa_spec: "swagger=2.0", "host=www.domain.com", "base_path=/basePath"
	sa_spec_schemes: "http"
	sa_consumes: "text", "text/json"
	sa_produces: "text"
	sa_tag: "name=tagName", "description=tagDescription"
	sa_scope: "name=test", "assdf=test2"
	sa_security_scheme: "scopes=test", "type=blubb", "description=this is a description", "name=this is a name", "in=query", "flow=implicit", "authorization_url=http://www.foo.com", "token_url=http://www.bar.com"
	sa_external_doc: "description=my description", url="http://ww.domain.com"
```
Whereas, whenever the swagger object allows an array, the annotation tag can be used several times. E.g.:
```Eiffel
  sa_tag: "name=firstTagName", "description=firstTagDescription"
  sa_tag: "name=secondTagName", "description=secondTagDescription"
```

In cases, where other objects are referenced within an object, such as the scopes object in the security scheme, it is important, to first define the referenced object and then to just use the given name as the parameter (as shown in the example).

### Paths Object
The paths object will be created from the operations defined in the feautre clauses. To define a new operation insert at the note section of the respective feature following annotations:

```Eiffel
feature

  foo: INTEGER
  		note
  			sa_operation: "operation=get", "summary=this is a summary", "description=description", "operation_id=my first operation", "deprecated=false", "path=/blubb"
  			sa_response: "status_code=400", "description=blubb", "schema=schema1"
  	do
  	    ...
  	end
```

The rules on which fields are required and which aren't can be taken from [the specs](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#operationObject).

```Eiffel
feature 
  
  foo: INTEGER
    note
      			sa_operation: "operation=get", "summary=this is a summary", "description=description", "operation_id=my first operation", "deprecated=false", "path=/blubb"
			sa_tags: "tag1", "tag2"
			sa_consumes: "text/xml", "text/json"
			sa_produces: "image"
			sa_schemes: "http", "ws"
			sa_schema: "name=schema1", "ref=#/definitions/Pet"
			sa_response: "status_code=400", "description=blubb", "schema=schema1" 
			sa_parameter: "in=body", "name=body", "description=first parameter", "required=false", "schema=schema1"
		do
		  ...
		end
```
The parameters for each object can be taken from the [swagger specs](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md).Remeber for nested objects, to first declare the object before the reference.

### Legal Annotations
Following a list of the swagger objects and their corresponding annotations:
#### class note section
annotation | swagger object
-----------|---------------
sa_spec|[swagger Object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#swaggerObject)
sa_info|[info Object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#infoObject)
sa_consumes|consumes field of [swagger Object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#swaggerObject])
sa_produces|produces field of [swagger Object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#swaggerObject)
sa_schemes|schemes field of [swagger Object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#swaggerObject)
sa_definition|a [definition](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#schemaObject) of the swager object's definitions
sa_schema| definition of a [schema object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#schemaObject)
sa_header| definition of a [header object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#headerObject)
sa_response|one [response](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#responseObject) of the response definitions of the swagger object (can be defined more than once)
sa_parameter|one [parameter](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#responseObject) of the parameter definitions of the swagger object (can be defined mulitple times)
sa_security_definition| one [security definition](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securitySchemeObject) of the security definitions of the swagger object (can be defined mulitple times)
sa_scope|definitoin of a [scope object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#scopesObject)
sa_security|one [security requirement definition](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securityRequirementObject) of the secuirty requirement definitions of the swagger object (can be defined mulitple times)
sa_tag| one [tag object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#tagObject) of the secuirty requirement definitions of the swagger object (can be defined mulitple times)
sa_external_doc_def|a external [documentation definition](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#externalDocumentationObject)
sa_external_doc|one [external doc](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#externalDocumentationObject) of the external documentations of the swagger object (can be defined mulitple times)
sa_info| definition of the [info object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#infoObject)
sa_contact| definition of the info object's [contact](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#contactObject)
sa_license|definition of the info object's [license](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#licenseObject)

#### feature note section
annotation | swagger object
-----------|---------------
sa_parameter| either a [parameter](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#parameterObject) or a [reference](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#referenceObject)
sa_response|a [response](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#responseObject) of the responses definition of the operation object
sa_header| [header](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#headerObject) declaration of a header object
sa_operation | definition of the [operation object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#operationObject), additional parameter: 'operation', legal values: get, put, post, delete, options, head, patch 
sa_tags| tags definiton of the operation object
sa_consumes|consumes definition of the operation object
sa_produces|produces definition of the operation object
sa_schemes|schemes definition of the operation object
sa_external_doc_def|declaration of an external documentation
sa_security_requirement|one entry of the [security requirements](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securityRequirementObject) of the operation object
sa_schema|declaration of a [schema object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#schemaObject)
sa_xm|declaration of a xml [object](https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#xmlObject)

## Scope
This initial implementation emerged from a students project of ETH Zürich. The requirement was to implement a library that produces a swagger.json file from some kind of Eiffel code annotations.

## General Design
Generating the swagger documentation consists basically of three steps: parsing the annotations, creating the json object structure and writing the json file.

### Parsing the Annotation
To parse the annotations, the class INDEXING_NOTES_VISITOR was created, that inherits from the AST_NULL_VISITOR. In case of creating a new visitor, the features process_index_as, process_class_as, process_feature_as, process_feature_clause_as, process_indexing_clause_as must be implemented. Currently there are four classes inheriting from the INDEXING_NOTES_VISITOR: SWAGGER_OBJECT_CREATOR, INFO_OBJECT_CREATOR, PATHS_OBJECT_CREATOR and ANNOTATION_VALIDATOR_VISITOR. First the validator ensures, that all annotations are declared in the right form, and that no required fields are missing. Then the swagger object creator has instances of the INFO_OBJECT_CREATOR and PATHS_OBJECT_CREATOR. From a list of parsed classes it creates the swagger object.

### Creating the JSON Object
In order to create the JSON object another visitor, SWAGGER_VISITOR, was created. If a class inherits from SWAGGER_VISITOR, it must implement features, that will visit all the SWAGGER_API_OBJECTS. The JSON_GENERATOR implements the SWAGGER_VISITOR and creates the JSON Object structure.

### Writing the .json file
To write the .json file another visitor class was created: JSON_VISITOR. This pretty prints a JSON_OBJECT into a .json file.

## Status of the Project
Most functionality is implemented, some objects are missing, such as Example Object. Also the fields describing a default value and enum are not implemented yet.

## Future work
* implementation of the missing features mentioned above
* Fine tuning the ANNOTATION_VALIDATOR
* implementing a validator, that ensures, that the swagger object is legal (i.e. all required fields are declared)

