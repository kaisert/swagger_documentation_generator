note
	description: "Summary description for {SECURITY_REQUIREMENT_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_REQUIREMENT_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		--initializes a new instance
		do
			initialize
		end
feature
	requirements: LINKED_LIST[TUPLE[STRING, LINKED_LIST[STRING]]]

	add_requirement(a_requirement: TUPLE[STRING, LINKED_LIST[STRING]])
		-- adds a requirement
		do
			if requirements = void then
				create requirements.make
			end
			requirements.extend(a_requirement)
		end
feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_security_requirement_object(current)
		end
end
