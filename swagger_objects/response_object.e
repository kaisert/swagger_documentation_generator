note
	description: "Summary description for {RESPONSE_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESPONSE_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make(a_description: STRING)
		-- initializes a new instance
		do
			initialize
			description := a_description
		end

feature
	description: STRING
		-- short description of the response
	schema: SCHEMA_OBJECT
		-- definition of the response structure
	headers: HEADERS_OBJECT
		-- list of headres that are sent with the response
	examples: EXAMPLE_OBJECT
		-- an example of the response message

	set_schema(a_schema: SCHEMA_OBJECT)
		-- sets the schema
		do
			schema := a_schema
		end
	set_headers(a_headers: HEADERS_OBJECT)
		-- sets the headers
		do
			headers := a_headers
		end
	set_examples(a_examples: EXAMPLE_OBJECT)
		-- sets the examples
		do
			examples := a_examples
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_response_object(current)
		end
end
