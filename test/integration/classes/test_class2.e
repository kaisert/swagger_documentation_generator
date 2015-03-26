note
	description: "Summary description for {TEST_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	sa_path: "/test_base_path2"
	sa_schema: "name=schema2", "ref=#/definitions/Pet"
	sa_parameter: "path=/test_base_path2/blubb", "in=body", "name=base_parameter", "description=first parameter", "required=false", "schema=schema2"
class

	TEST_CLASS2

feature

--	foo: INTEGER
--		note
--	sa_operation: "operation=get", "summary=this is a summary", "description=description", "operation_id=my first operation", "deprecated=false", "path=/blubb"
--			sa_operation_tags: "tag1", "tag2"
--			sa_operation_consumes: "text/xml", "text/json"
--			sa_operation_produces: "image"
--			sa_operation_schemes: "http", "ws"
--			sa_schema: "name=schema1", "ref=#/definitions/Pet"
--			sa_response: "status_code=400", "description=blubb", "schema=schema1" --, "header=header1"
--			sa_parameter: "in=body", "name=body", "description=first parameter", "required=false", "schema=schema1"
--		do
--		end

--	bar (i: INTEGER): STRING
--		note
--			sa_operation: "operation=put", "summary=this is a summary", "description=description", "operation_id=my first operation", "deprecated=false", "path=/blubb"
--			sa_operation_tags: "tag1", "tag2"
--			sa_operation_consumes: "text/xml", "text/json"
--			sa_operation_produces: "image"
--			sa_operation_schemes: "http", "ws"
--			sa_schema: "name=schema1", "ref=#/definitions/Pet"
--			sa_response: "status_code=400", "description=blubb", "schema=schema1" --, "header=header1"
--		do
--			result := i.out
--		end

end
