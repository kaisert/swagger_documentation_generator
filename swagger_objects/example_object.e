note
	description: "Summary description for {EXAMPLE_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		-- initializes a new instance
		do
			initialize
		end

feature
	example: ANY
		-- an example object
	set_example(a_example: ANY)
		-- sets an example
		do
			example := a_example
		end

feature --visitor
process(v: SWAGGER_VISITOR)
	do
		v.process_example_object(current)
	end

end
