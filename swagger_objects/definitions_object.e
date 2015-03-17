note
	description: "Summary description for {DEFINITIONS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEFINITIONS_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		--initializes a new instance
		do
			initialize
		end
feature
	definitions: LINKED_LIST[TUPLE[STRING, SCHEMA_OBJECT]]
		-- definitions mapping a name to the schema it defines

	add_definition(a_definition: TUPLE[STRING, SCHEMA_OBJECT])
		-- adds a definition
		do
			if definitions = void then
				create definitions.make
			end
			definitions.extend(a_definition)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_definitions_object(current)
		end
end
