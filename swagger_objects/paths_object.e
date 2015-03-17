note
	description: "Summary description for {PATHS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PATHS_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		--initialize new instance
		do
			initialize
		end

feature
	path: PATH_ITEM_OBJECT

	set_path(a_path: PATH_ITEM_OBJECT)
		-- sets the path
		do
			path := a_path
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_paths_object(current)
		end

end
