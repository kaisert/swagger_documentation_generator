note
	description: "Base class of a JSON object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_VALUE_OBJECT

feature {JSON_VISITOR}
	-- visit

	process (v: JSON_VISITOR)
		deferred
		end

end
