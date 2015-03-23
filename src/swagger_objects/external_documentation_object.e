note
	description: "Summary description for {EXTERNAL_DOCUMENTATION_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_DOCUMENTATION_OBJECT
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
	description: STRING
		-- a short description of the target documentation
	url: STRING
		-- th URL for the target documentation
	set_url(a_url: STRING)
		-- seths the url
		do
			url := a_url
		end
	set_description(a_description: STRING)
		-- sets the description
		do
			description := a_description
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_external_documentation_object(current)
		end

end
