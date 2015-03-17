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
	responses: LINKED_LIST[TUPLE[STRING, RESPONSE_OBJECT]]
		-- response defionitions, mapping a name to the parameter it defines

	add_responses(a_response: TUPLE[STRING, RESPONSE_OBJECT])
		-- adds a response
		do
			if responses = void then
				create responses.make
			end
			responses.extend(a_response)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_responses_definitions_object(current)
		end
end
