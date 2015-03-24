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
			create definitions.make (10)
		end

feature

	definitions: HASH_TABLE [SCHEMA_OBJECT, STRING]
			-- definitions mapping a name to the schema it defines

	set_definitions (some_definition: HASH_TABLE [SCHEMA_OBJECT, STRING])
			-- adds a definition
		do
			definitions := some_definition
		end

feature {SWAGGER_VISITOR}
	--visitor

	process (v: SWAGGER_VISITOR)
		do
			v.process_definitions_object (current)
		end

end
