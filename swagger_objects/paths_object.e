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
			create paths.make
		end

feature
	paths: LINKED_LIST[TUPLE[STRING,PATH_ITEM_OBJECT]]

	add_path(a_path: TUPLE[STRING,PATH_ITEM_OBJECT])
		-- sets the path
		do
			paths.extend(a_path)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_paths_object(current)
		end

end
