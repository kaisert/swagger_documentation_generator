note
	description: "Summary description for {TEST_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	SA_SPEC: "2.0"
	SA_INFO: "version=1.0.0", "title=TEST_CLASS"
	SA_CONTACT: "name=API Support",  "url=http://www.swagger.io/support", "email=support@swagger.io"
	SA_LICENSE: "name=Apache 2.0", "url=http://www.apache.org/licenses/LICENSE-2.0.html"

--	sa_path: "/test_base_path"

class
	TEST_CLASS
feature
	test_feature(STRING: id): INTEGER
	note
		sa_operation: "operation=get", "summary=this is a summary", "description=description", "operation_id=my first operation", "deprecated=false", "path=/blubb"
		sa_operation_tags: "tag1", "tag2"
		sa_operation_consumes: "text/xml", "text/json"
		sa_operation_produces: "image"
		sa_operation_schemes: "http", "ws"
--		sa_schema: "name=schema1", "ref=#/definitions/Pet"
		sa_response: "status_code=400", "description=blubb" --, "schema=schema1", "header=header1"
		--sa_parameter: "in=body", "name=body", "description=first parameter", "required=false", "schema=schema1"
	do

	end

	blubb(i: INTEGER): STRING
		do
				result := i.out
		end
end
