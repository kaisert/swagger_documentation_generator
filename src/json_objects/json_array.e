note
	description: "Summary description for {JSON_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ARRAY [G -> JSON_VALUE_OBJECT]

inherit

	JSON_VALUE_OBJECT

create
	make

feature
	--initialize

	make
		do
			create value.make
		end

feature

	value: LINKED_LIST [G]

feature
	-- visit

	process (v: JSON_VISITOR)
		do
			v.process_json_array (current)
		end

end
