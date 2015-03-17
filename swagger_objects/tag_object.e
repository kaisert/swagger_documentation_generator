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
	make(a_name: STRING)
		-- initializes a new instance
		do
			initialize
			name := a_name
		end

feature
	name: STRING
	description: STRING
	external_docs: EXTERNAL_DOCUMENTATION_OBJECT

	set_description(a_description: STRING)
		--
		do
			description := a_description
		end
	set_external_docs(a_external_doc: EXTERNAL_DOCUMENTATION_OBJECT)
		--
		do
			external_docs := a_external_doc
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_tag_object(current)
		end
end
