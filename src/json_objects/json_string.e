note
	description: "Summary description for {JSON_STRING}."
	author: ""
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
		do
			value := a_value
		end

	value: STRING

feature
	-- visit

	process (v: JSON_VISITOR)
		do
			v.process_json_string (current)
		end

end
