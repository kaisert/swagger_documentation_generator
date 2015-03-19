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
			create responses.make(10)
			create references.make
		end

feature
	default_value: RESPONSE_OBJECT

	responses: HASH_TABLE[RESPONSE_OBJECT, STRING]

	references: LINKED_LIST[REFERENCE_OBJECT]

--	set_responses(some_responses: HASH_TABLE[RESPONSE_OBJECT, STRING])
--		-- sets the responses
--		do
--			responses := some_responses
--		end

	add_reference(a_reference: REFERENCE_OBJECT)
		--adds a reference
		do
			if references = void then
				create references.make
			end
			references.extend(a_reference)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_responses_object(current)
		end
end
