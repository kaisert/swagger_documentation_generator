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
			create security_schemes.make(10)
		end

feature
	security_schemes: HASH_TABLE[SECURITY_SCHEME_OBJECT, STRING]
		-- response defionitions, mapping a name to the parameter it defines

	set_security_scheme(some_schemes: HASH_TABLE[SECURITY_SCHEME_OBJECT, STRING])
		-- adds a response
		do
			security_schemes := some_schemes
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_security_definitions_object(current)
		end
end
