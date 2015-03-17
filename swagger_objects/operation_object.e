note
	description: "Summary description for {OPERATION_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPERATION_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make(a_responses: RESPONSES_OBJECT)
		-- initialize new instance
		do
			initialize
			responses := responses
		end

feature
	tags: LINKED_LIST[STRING]
		--list of tags for API documentation control
	summary: STRING
		-- short summary of what the operation does
	description: STRING
		-- verbose explanation of the operation behavior
	external_docs: EXTERNAL_DOCUMENTATION_OBJECT
		-- additional external documentation for this operation
	operation_id: STRING
		-- friendly name for the operation
	consumes: LINKED_LIST[STRING]
		-- list of MIME types the operation can consume
	produces: LINKED_LIST[STRING]
		-- A list of MIME types the operation can produce
	parameters: LINKED_LIST[PARAMETER_OBJECT]
		-- list of parameters that are applicatble for this operation
	responses: RESPONSES_OBJECT
		-- list of possible responses
	schemes: LINKED_LIST[STRING]
		-- transfer protocol for the operation
	deprecated: BOOLEAN
		-- declares this operation to be deprecated
	security: LINKED_LIST[SECURITY_REQUIREMENT_OBJECT]
		-- declaration of which security shcemes are applied for this operation.

	add_tag(a_tag: STRING)
		-- adds a tag
		do
			if tags = void then
				create tags.make
			end
			tags.extend(a_tag)
		end

	set_summary(a_summary: STRING)
		-- sets the summary
		do
			summary := a_summary
		end

	set_description(a_description: STRING)
		-- sets the description
		do
			description := a_description
		end

	set_external_docs(a_external_docs: EXTERNAL_DOCUMENTATION_OBJECT)
		-- sets the external docs
		do
			external_docs := a_external_docs
		end

	set_operation_id(a_operation_id: STRING)
		-- sets the operation id
		do
			operation_id := a_operation_id
		end

	add_consumes(a_consume: STRING)
		-- adds a consume
		do
			if consumes = void then
				create consumes.make
			end
			consumes.extend (a_consume)
		end

	add_produces(a_produce: STRING)
		-- adds a produce
		do
			if produces = void then
				create produces.make
			end
			produces.extend (a_produce)
		end

	add_parameter(a_parameter: PARAMETER_OBJECT)
		-- adds a parameter
		do
			if parameters = void then
				create parameters.make
			end
			parameters.extend (a_parameter)
		end

	add_scheme(a_scheme: STRING)
		-- adds a scheme
		do
			if schemes = void then
				create schemes.make
			end
			schemes.extend (a_scheme)
		end

	set_deprecated(is_deprecated: BOOLEAN)
		-- sets the deprecated value
		do
			deprecated := is_deprecated
		end

	add_security(a_security: SECURITY_REQUIREMENT_OBJECT)
		-- adds a security
		do
			if security = void then
				create security.make
			end
			security.extend (a_security)
		end


feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_operation_object(current)
		end

end
