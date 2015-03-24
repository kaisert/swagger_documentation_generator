note
	description: "Summary description for {JSON_INTEGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_INTEGER

inherit

	JSON_VALUE_OBJECT

create
	make

feature

	make (a_value: INTEGER)
		do
			value := a_value
		end

	value: INTEGER

feature
	--visit

	process (v: JSON_VISITOR)
		do
			v.process_json_integer (current)
		end

end
