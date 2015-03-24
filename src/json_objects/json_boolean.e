note
	description: "Summary description for {JSON_BOOLEAN}."
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

	make (a_value: BOOLEAN)
		do
			value := a_value
		end

	value: BOOLEAN

feature
	--visit

	process (v: JSON_VISITOR)
		do
			v.process_json_boolean (current)
		end

end
