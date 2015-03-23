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
	headers: HASH_TABLE[HEADER_OBJECT, STRING]
		--the headers

	set_headers(a_header: HASH_TABLE[HEADER_OBJECT, STRING])
		-- adds a header
		do
			headers := a_header
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_headers_object(current)
		end

end
