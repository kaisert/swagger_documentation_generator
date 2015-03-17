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
		end

feature
	parameters: LINKED_LIST[TUPLE[STRING, PARAMETER_OBJECT]]
		-- parameter defionitions, mapping a name to the parameter it defines

	add_parameter(a_parameter: TUPLE[STRING, PARAMETER_OBJECT])
		-- adds a parameter
		do
			if parameters = void then
				create parameters.make
			end
			parameters.extend(a_parameter)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_parameters_definitions_object(current)
		end
end
