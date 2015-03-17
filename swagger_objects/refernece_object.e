note
	description: "Summary description for {REFERNECE_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make(a_ref: STRING)
		-- initializes a new instance
		do
			initialize
			ref := a_ref
		end

feature
	ref: STRING
		-- the reference string

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_reference_object(current)
		end
end
