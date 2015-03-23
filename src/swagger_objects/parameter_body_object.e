note
	description: "Summary description for {PARAMETER_BODY_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER_BODY_OBJECT
inherit
	PARAMETER_OBJECT
create
	make
feature
	make
		-- initializes a new instance
		do
			initialize
		end

feature
	schema: SCHEMA_OBJECT

	set_schema(a_schema: SCHEMA_OBJECT)
		-- sets the schema
		do
			schema := a_schema
		end

feature --visitor
process(v: SWAGGER_VISITOR)
	do
		v.process_parameter_body_object(current)
	end
end
