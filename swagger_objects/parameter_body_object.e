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
	make(a_name: STRING; a_in: STRING; a_schema: SCHEMA_OBJECT)
		-- initializes a new instance
		do
			name := a_name
			in := a_in
			schema := a_schema
		end

feature
	schema: SCHEMA_OBJECT

feature --visitor
process(v: SWAGGER_VISITOR)
	do
		v.process_parameter_body_object(current)
	end
end
