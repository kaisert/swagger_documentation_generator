note
	description: "Summary description for {LICENSE_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LICENSE_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make(a_name: STRING)
		-- initializes a new instance
		do
			initialize
			name := a_name
		end

feature
	name: STRING
		--license name used for the API
	url: detachable STRING
		-- url to the license used for the API

	set_url(a_url: STRING)
		--sets the url
		do
			url := a_url
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_license_object(current)
		end
end
