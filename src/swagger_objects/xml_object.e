note
	description: "Summary description for {XML_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_OBJECT

inherit

	SWAGGER_API_OBJECT

create
	make

feature

	make
			-- initializes a new instance
		do
			initialize
			wrapped := false
			is_attribute := false
		end

feature

	name: STRING
			--replaces the nam of the element/attribute used for the described shcema property

	namespace: STRING
			--the URL of the namespace definition

	prefix_string: STRING
			-- prefix to be used for the name

	is_attribute: BOOLEAN
			-- declares whether the property definition translates to an attribute instead
			-- of an element

	wrapped: BOOLEAN
			-- may be used only for an array definition. signifies whether the array
			-- is wrapped.

	is_attribute_is_set: BOOLEAN

	wrapped_is_set: BOOLEAN

	set_name (a_name: STRING)
			-- set the name
		do
			name := a_name
		end

	set_namespace (a_namespace: STRING)
			-- set the namespace
		do
			namespace := a_namespace
		end

	set_prefix (a_prefix: STRING)
			-- set the prefix
		do
			prefix_string := a_prefix
		end

	set_attribute (a_attribute: BOOLEAN)
			-- set the attribute
		do
			is_attribute := a_attribute
			is_attribute_is_set := true
		end

	set_wrapped (a_wrapped: BOOLEAN)
			-- set the wrapped
		do
			wrapped := a_wrapped
			wrapped_is_set := true
		end

feature {SWAGGER_VISITOR}
	--visitor

	process (v: SWAGGER_VISITOR)
		do
			v.process_xml_object (current)
		end

end
