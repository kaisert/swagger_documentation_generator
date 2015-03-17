note
	description: "Summary description for {HEADERS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADERS_OBJECT
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
	headers: LINKED_LIST[HEADER_OBJECT]
		--the headers

	add_header(a_header: HEADER_OBJECT)
		-- adds a header
		do
			if headers = void then
				create headers.make
			end
			headers.extend(a_header)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_headers_object(current)
		end

end
