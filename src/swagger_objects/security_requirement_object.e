note
	description: "Summary description for {SECURITY_REQUIREMENT_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_REQUIREMENT_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		--initializes a new instance
		do
			initialize
			create values.make
		end
feature
	field: STRING
	values: LINKED_LIST[STRING]

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_security_requirement_object(current)
		end

	set_field(f: STRING)
		do
			field := f
		end
end
