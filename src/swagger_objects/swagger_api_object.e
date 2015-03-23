note
	description: "Summary description for {SWAGGER_API_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SWAGGER_API_OBJECT

feature
	--children: LINKED_LIST[SWAGGER_API_OBJECT]

	initialize
		do
			
		end

process(v: SWAGGER_VISITOR)
	-- visitor feature
	require
		v_not_void: v /= void
	deferred
	end

end
