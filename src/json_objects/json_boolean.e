note
	description: "object representing a JSON boolean value"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_BOOLEAN

inherit

	JSON_VALUE_OBJECT

create
	make

feature
	-- access

	make (a_value: BOOLEAN)
		do
			value := a_value
		end

	value: BOOLEAN

feature {JSON_VISITOR}
	--visit

	process (v: JSON_VISITOR)
		do
			v.process_json_boolean (current)
		end

end
