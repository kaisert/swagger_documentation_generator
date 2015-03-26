note
	description: "Object representing a json integer"
	author: "Tobias Kaiser"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_INTEGER

inherit

	JSON_VALUE_OBJECT

create
	make

feature
	-- access

	make (a_value: INTEGER)
		do
			value := a_value
		end

	value: INTEGER

feature {JSON_VISITOR}
	--visit

	process (v: JSON_VISITOR)
		do
			v.process_json_integer (current)
		end

end
