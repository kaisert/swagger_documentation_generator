note
	description: "Summary description for {SCOPES_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOPES_OBJECT

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

	scopes: LINKED_LIST [TUPLE [STRING, STRING]]
			-- Maps between a name of a scope to a short description of it

	add_scope (a_scope: TUPLE [STRING, STRING])
			-- adds a scope
		do
			if scopes = void then
				create scopes.make
			end
			scopes.extend (a_scope)
		end

feature --visitor

	process (v: SWAGGER_VISITOR)
		do
			v.process_scopes_object (current)
		end

end
