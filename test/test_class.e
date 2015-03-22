note
	description: "Summary description for {TEST_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	SA_SPEC: "swagger=2.0", "host=www.domain.com", "base_path=/basePath"
	sa_spec_schemes: "http"
	sa_consumes: "text"
	sa_produces: "text"
	SA_INFO: "version=1.0.0", "title=TEST_CLASS"
	SA_CONTACT: "name=API Support", "url=http://www.swagger.io/support", "email=support@swagger.io"
	SA_LICENSE: "name=Apache 2.0", "url=http://www.apache.org/licenses/LICENSE-2.0.html"
	sa_security_scheme: "type=blubb", "description=this is a description", "name=this is a name", "in=query", "flow=implicit", "authorization_url=http://www.foo.com", "token_url=http://www.bar.com"

	sa_path: "/test_base_path"
class
	TEST_CLASS

feature

	foo: INTEGER
		note
			sa_operation: "operation=get", "summary=this is a summary", "description=description", "operation_id=my first operation", "deprecated=false", "path=/blubb"
			sa_operation_tags: "tag1", "tag2"
			sa_operation_consumes: "text/xml", "text/json"
			sa_operation_produces: "image"
			sa_operation_schemes: "http", "ws"
			sa_schema: "name=schema1", "ref=#/definitions/Pet"
			sa_response: "status_code=400", "description=blubb", "schema=schema1" --, "header=header1"
			--sa_parameter: "in=body", "name=body", "description=first parameter", "required=false", "schema=schema1"
		do
		end

	bar (i: INTEGER): STRING
		note
			sa_operation: "operation=put", "summary=this is a summary", "description=description", "operation_id=my first operation", "deprecated=false", "path=/blubb"
			sa_operation_tags: "tag1", "tag2"
			sa_operation_consumes: "text/xml", "text/json"
			sa_operation_produces: "image"
			sa_operation_schemes: "http", "ws"
			sa_schema: "name=schema1", "ref=#/definitions/Pet"
			sa_response: "status_code=400", "description=blubb", "schema=schema1" --, "header=header1"
		do
			result := i.out
		end

end
