note
	description: "Summary description for {RESPONSES_DEFINITIONS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESPONSES_DEFINITIONS_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		-- initializes a new instance
		do
			initialize
		end

feature
	responses: HASH_TABLE[RESPONSE_OBJECT, STRING]
		-- response defionitions, mapping a name to the parameter it defines

	set_responses(some_responses: HASH_TABLE[RESPONSE_OBJECT, STRING])
		-- adds a response
		do
			responses := some_responses
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_responses_definitions_object(current)
		end
end
