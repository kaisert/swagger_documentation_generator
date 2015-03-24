note
	description: "Summary description for {JSON_VALUE_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_VALUE_OBJECT

feature {JSON_VISITOR}
	process(v: JSON_VISITOR)
		deferred
		end

end
