note
	description: "Summary description for {JSON_REAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_REAL

inherit

	JSON_VALUE_OBJECT
create
	make
feature
	make(a_value: REAL)
	do
		value := a_value
	end
	value: REAL

feature
	--visit

	process (v: JSON_VISITOR)
		do
			v.process_json_real (current)
		end

end
