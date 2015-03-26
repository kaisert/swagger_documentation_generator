note
	description: "Object representing a JSON string"
	author: "Tobias Kaiser"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_STRING

inherit

	JSON_VALUE_OBJECT

create
	make

feature

	make (a_value: STRING)
			-- creates a new instance
		do
			value := a_value
		end

	value: STRING

feature {JSON_VISITOR}
	-- visit

	process (v: JSON_VISITOR)
		do
			v.process_json_string (current)
		end

end
