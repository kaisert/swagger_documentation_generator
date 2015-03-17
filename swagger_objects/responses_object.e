note
	description: "Summary description for {RESPONSES_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESPONSES_OBJECT
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
	default_value: RESPONSE_OBJECT

	responses: LINKED_LIST[RESPONSE_OBJECT]

	add_response(response: RESPONSE_OBJECT)
		--adds a response
		do
			if responses = void then
				create responses.make
			end
			responses.extend(response)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_responses_object(current)
		end
end
