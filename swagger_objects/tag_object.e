note
	description: "Summary description for {TAG_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_OBJECT

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

	name: STRING

	description: STRING

	external_docs: EXTERNAL_DOCUMENTATION_OBJECT

	set_name (a_name: STRING)
			-- sets the name
		do
			name := a_name
		end

	set_description (a_description: STRING)
			-- sets the description
		do
			description := a_description
		end

	set_external_docs (a_external_doc: EXTERNAL_DOCUMENTATION_OBJECT)
			-- sets the external docs
		do
			external_docs := a_external_doc
		end

feature --visitor

	process (v: SWAGGER_VISITOR)
		do
			v.process_tag_object (current)
		end

end
