note
	description: "Summary description for {PARAMETERS_DEFINITIONS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETERS_DEFINITIONS_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		-- initializes a new instance
		do
			initialize
			create parameters.make(10)
		end

feature
	parameters: HASH_TABLE[PARAMETER_OBJECT, STRING]
		-- parameter defionitions, mapping a name to the parameter it defines

	set_parameters(some_parameters: HASH_TABLE[PARAMETER_OBJECT, STRING])
		-- adds a parameter
		do
			parameters := some_parameters
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_parameters_definitions_object(current)
		end
end
