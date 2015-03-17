note
	description: "Summary description for {SECURITY_DEFINITIONS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_DEFINITIONS_OBJECT
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
	security_schmemes: LINKED_LIST[TUPLE[STRING, SECURITY_SCHEME_OBJECT]]
		-- response defionitions, mapping a name to the parameter it defines

	add_security_scheme(a_scheme: TUPLE[STRING, SECURITY_SCHEME_OBJECT])
		-- adds a response
		do
			if security_schmemes = void then
				create security_schmemes.make
			end
			security_schmemes.extend(a_scheme)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_security_definitions_object(current)
		end
end
