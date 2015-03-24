note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_SWAGGER_OBJECT_CREATOR

inherit

	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			default_create
		end

feature {NONE} -- Events

	target: SWAGGER_OBJECT_CREATOR

	on_prepare
			-- <Precursor>
		do
			create target.make
			create annotations.make
		end

	on_clean
			-- <Precursor>
		do
				--assert ("not_implemented", False)
		end

	create_index_as (a_tag: STRING; indexes: LINKED_LIST [STRING]): INDEX_AS
		local
			temp_e_list: EIFFEL_LIST [ATOMIC_AS]
		do
			create temp_e_list.make (indexes.count)
			across
				indexes as i
			loop
				temp_e_list.extend (create {STRING_AS}.initialize (i.item, 0, 0, 0, 0, 0, 0, 0))
			end
			create result.initialize (create {ID_AS}.initialize (a_tag), temp_e_list, create {SYMBOL_AS}.make (1, 1, 1, 1, 1, 1, 1, 1))
		end

	lists_contain_same_elements (l1, l2: LINKED_LIST [STRING]): BOOLEAN
		require
			l1_not_void: l1 /= Void
			l2_not_void: l2 /= Void
		LOCAL
			s: STRING
		do
			result := l1.count = l2.count
			across
				l1 as l
			loop
				s := l.item
				result := result and contains_string (s, l2)
			end
		end

	contains_string (s: STRING; l: LIST [STRING]): BOOLEAN
		require
			s_not_void: s /= Void
			l_not_void: l /= Void
		do
			result := false
			across
				l as list
			loop
				result := result or list.item.same_string (s)
			end
		end

feature {NONE}

	index: INDEX_AS

	annotations: LINKED_LIST [STRING]

	tag: STRING

feature -- Test routines

	test_test
	do
		assert("true", true)
	end

	test_spec_annotation
			-- New test routine
		note
			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_swagger_spec"
		local
			swagger, host, base_path: STRING
		do
			tag := "sa_spec"
			swagger := "2.0"
			host := "myHost"
			base_path := "/path"
			annotations.extend ("swagger=" + swagger)
			annotations.extend ("host=" + host)
			annotations.extend ("base_path=" + base_path)
			index := create_index_as (tag, annotations)
			target.process_index_as (index)
			assert ("spec not set", target.swagger_object.swagger.same_string (swagger))
			assert ("host not set", target.swagger_object.host.same_string (host))
			assert ("base_path not set", target.swagger_object.base_path.same_string (base_path))
		end

	test_consumes_annotation
		note
			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_list"
		do
			tag := "sa_consumes"
			annotations.extend ("consume0")
			index := create_index_as (tag, annotations)
			target.process_index_as (index)
			assert ("consumes not set", lists_contain_same_elements (annotations, target.swagger_object.consumes))
		end

--	test_produces_annotation
--		note
--			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_list"
--		do
--			tag := "sa_produces"
--			annotations.extend ("produce0")
--			index.process (target)
--			target.process_index_as (index)
--			assert ("produces not set", lists_contain_same_elements (annotations, target.swagger_object.produces))
--		end

--	test_schemes_annotation
--		note
--			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_list"
--		do
--			tag := "sa_schemes"
--			annotations.extend ("scheme0")
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("scheme not set", lists_contain_same_elements (annotations, target.swagger_object.schemes))
--		end

--		--test_definition_annotation

--	test_schema_annotation
--		note
--			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_schema"
--		local
--			name, ref, format, description, pattern, type, discriminator, title: STRING
--			multiple_of: REAL
--			maximum: REAL
--			exclusiveMaximum: BOOLEAN
--			minimum: REAL
--			exclusiveMinimum: BOOLEAN
--			maxLength: INTEGER
--			minLength: INTEGER
--			maxItems: INTEGER
--			minItems: INTEGER
--			uniqueItems: BOOLEAN
--			maxProperties: INTEGER
--			minProperties: INTEGER
--			required: BOOLEAN
--			readonly: BOOLEAN
--		do
--			name := "schema_name"
--			ref := "ref"
--			format := "format"
--			title := "title"
--			description := "description"
--			multiple_of := 1.0
--			maximum := 1.0
--			exclusiveMaximum := true
--			minimum := 1.0
--			exclusiveMinimum := true
--			maxLength := 1
--			minLength := 1
--			pattern := "pattern"
--			maxItems := 1
--			minItems := 1
--			uniqueItems := true
--			maxProperties := 1
--			minProperties := 1
--			required := true
--			readonly := true
--			annotations.extend ("name=" + name)
--			annotations.extend ("ref=" + ref.out)
--			annotations.extend ("name=" + name.out)
--			annotations.extend ("format=" + format.out)
--			annotations.extend ("description=" + description.out)
--			annotations.extend ("pattern=" + pattern.out)
--			annotations.extend ("type=" + type.out)
--			annotations.extend ("discriminator=" + discriminator.out)
--			annotations.extend ("multiple_of=" + multiple_of.out)
--			annotations.extend ("maximum=" + maximum.out)
--			annotations.extend ("minimum=" + minimum.out)
--			annotations.extend ("exclusive_maximum=" + exclusiveMaximum.out)
--			annotations.extend ("exclusive_minimum=" + exclusiveMinimum.out)
--			annotations.extend ("unique_items=" + uniqueItems.out)
--			annotations.extend ("required=" + required.out)
--			annotations.extend ("read_only=" + readOnly.out)
--			annotations.extend ("max_length=" + maxLength.out)
--			annotations.extend ("min_length=" + minLength.out)
--			annotations.extend ("min_items=" + minItems.out)
--			annotations.extend ("max_items=" + maxItems.out)
--			annotations.extend ("max_properties=" + maxProperties.out)
--			annotations.extend ("min_properties=" + minProperties.out)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("incorrect count", target.known_schemes.count = 1)
--			assert ("ref not set", target.known_schemes [name].ref.same_string (ref))
--			assert ("format not set", target.known_schemes [name].format.same_string (format))
--			assert ("description not set", target.known_schemes [name].description.same_string (description))
--			assert ("pattern not set", target.known_schemes [name].pattern.same_string (pattern))
--			assert ("type not set", target.known_schemes [name].type.same_string (type))
--			assert ("discriminator not set", target.known_schemes [name].discriminator.same_string (discriminator))
--			assert ("multiple_of not set", target.known_schemes [name].multiple_of = multiple_of)
--			assert ("maximum not set", target.known_schemes [name].maximum = multiple_of)
--			assert ("minimum not set", target.known_schemes [name].minimum = multiple_of)
--			assert ("exclusive_maximum not set", target.known_schemes [name].exclusivemaximum = exclusivemaximum)
--			assert ("exclusive_minimum not set", target.known_schemes [name].exclusiveminimum = exclusiveminimum)
--			assert ("unique_items not set", target.known_schemes [name].uniqueitems = uniqueitems)
--			assert ("required not set", target.known_schemes [name].required = required)
--			assert ("read_only not set", target.known_schemes [name].read_only = readonly)
--			assert ("max_length not set", target.known_schemes [name].maxlength = maxlength)
--			assert ("min_length not set", target.known_schemes [name].minlength = minlength)
--			assert ("min_items not set", target.known_schemes [name].minitems = minitems)
--			assert ("max_items not set", target.known_schemes [name].maxitems = maxitems)
--			assert ("max_properties not set", target.known_schemes [name].maxproperties = maxproperties)
--			assert ("min_properties not set", target.known_schemes [name].minproperties = minproperties)
--		end

--	test_definition_annotation
--		local
--		do
--		end

--	test_header_annotation
--		local
--			name: STRING
--			description: STRING
--			type: STRING
--			format: STRING
--			collection_format: STRING
--			maximum: REAL
--			exclusive_maximum: BOOLEAN
--			minimum: REAL
--			exclusive_minimum: BOOLEAN
--			max_length: INTEGER
--			min_length: INTEGER
--			pattern: STRING
--			max_items: INTEGER
--			min_items: INTEGER
--			unique_items: BOOLEAN
--			multiple_of: REAL
--		do
--			tag := "sa_header"
--			description := "description"
--			name := "name"
--			type := "type"
--			format := "format"
--			collection_format := "collection_format"
--			maximum := 1.0
--			exclusive_maximum := true
--			minimum := 1.0
--			exclusive_minimum := true
--			max_length := 1
--			min_length := 1
--			pattern := "pattern"
--			max_items := 1
--			min_items := 1
--			unique_items := true
--			multiple_of := 1.0
--			annotations.extend ("type=" + type.out)
--			annotations.extend ("format=" + format.out)
--			annotations.extend ("collection_format=" + collection_format.out)
--			annotations.extend ("maximum=" + maximum.out)
--			annotations.extend ("exclusive_maximum=" + exclusive_maximum.out)
--			annotations.extend ("minimum=" + minimum.out)
--			annotations.extend ("exclusive_minimum=" + exclusive_minimum.out)
--			annotations.extend ("max_length=" + max_length.out)
--			annotations.extend ("min_length=" + min_length.out)
--			annotations.extend ("pattern=" + pattern.out)
--			annotations.extend ("max_items=" + max_items.out)
--			annotations.extend ("min_items=" + min_items.out)
--			annotations.extend ("unique_items=" + unique_items.out)
--			annotations.extend ("multiple_of=" + multiple_of.out)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("not right count", target.known_headers.count = 1)
--			assert ("type not set", target.known_headers [name].type.same_string (type))
--			assert ("format not set", target.known_headers [name].format.same_string (format))
--			assert ("collection_format not set", target.known_headers [name].collection_format.same_string (collection_format))
--			assert ("maximum not set", target.known_headers [name].maximum = maximum)
--			assert ("exclusive_maximum not set", target.known_headers [name].exclusive_maximum = exclusive_maximum)
--			assert ("minimum not set", target.known_headers [name].minimum = minimum)
--			assert ("exclusive_minimum not set", target.known_headers [name].exclusive_minimum = exclusive_minimum)
--			assert ("max_length not set", target.known_headers [name].max_length = max_length)
--			assert ("min_length not set", target.known_headers [name].min_length = min_length)
--			assert ("pattern not set", target.known_headers [name].pattern.same_string (pattern))
--			assert ("max_items not set", target.known_headers [name].max_items = max_items)
--			assert ("min_items not set", target.known_headers [name].min_items = min_items)
--			assert ("unique_items not set", target.known_headers [name].unique_items = unique_items)
--			assert ("multiple_of not set", target.known_headers [name].multiple_of = multiple_of)

--				--enum: LINKED_LIST [ANY]
--				--default_value: ANY
--				-- items: ITEMS_OBJECT
--		end

--	test_response_annotation
--		local
--			description: STRING
--			schema: SCHEMA_OBJECT
--			schema_name: STRING
--			header: HEADER_OBJECT
--			header_name: STRING
--			status_code: STRING
--		do
--			tag := "sa_response"
--			description := "description"
--			header_name := "header_name"
--			schema_name := "schema_name"
--			status_code := "status_code"
--			create schema.make
--			create header.make
--			target.known_headers.extend (header, header_name)
--			target.known_schemes.extend (schema, schema_name)
--			annotations.extend ("description=" + description)
--			annotations.extend ("header=" + header_name)
--			annotations.extend ("schema=" + schema_name)
--			annotations.extend ("status_code=" + status_code)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("description not set", target.swagger_object.responses.responses [status_code].description.same_string (description))
--			assert ("header not set", target.swagger_object.responses.responses [status_code].headers.headers [header_name] = header)
--			assert ("schema not set", target.swagger_object.responses.responses [status_code].schema = schema)
--				--example
--		end

--	test_parameter_annotation
--		local
--		do
--		end

--	test_security_scheme_annotation
--		local
--			type, description, name, in, flow, authorization_url, token_url, scope_name: STRING
--			scopes: SCOPES_OBJECT
--		do
--			tag := "sa_security_scheme"
--			type := "type"
--			description := "description"
--			name := "name"
--			in := "in"
--			flow := "flow"
--			authorization_url := "authorization_url"
--			token_url := "token_url"
--			scope_name := "scope"
--			tag := "sa_security_scheme"
--			create scopes.make
--			target.known_scopes.extend (scopes, scope_name)
--			annotations.extend ("type=" + type)
--			annotations.extend ("description=" + description)
--			annotations.extend ("name=" + name)
--			annotations.extend ("in=" + in)
--			annotations.extend ("flow=" + flow)
--			annotations.extend ("authorization_url=" + authorization_url)
--			annotations.extend ("token_url=" + token_url)
--			annotations.extend ("scope=" + scope_name)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("type set", target.swagger_object.security_definitions.security_schemes [name].type.same_string (type))
--			assert ("description set", target.swagger_object.security_definitions.security_schemes [name].description.same_string (description))
--			assert ("name set", target.swagger_object.security_definitions.security_schemes [name].name.same_string (name))
--			assert ("in set", target.swagger_object.security_definitions.security_schemes [name].in.same_string (in))
--			assert ("flow set", target.swagger_object.security_definitions.security_schemes [name].flow.same_string (flow))
--			assert ("authorization_url set", target.swagger_object.security_definitions.security_schemes [name].authorization_url.same_string (authorization_url))
--			assert ("token_url set", target.swagger_object.security_definitions.security_schemes [name].token_url.same_string (token_url))
--			assert ("scope set", target.swagger_object.security_definitions.security_schemes [name].scopes = scopes)
--		end

--	test_scope_annotation
--		local
--			scope, scope_description, scope_name: STRING
--		do
--			scope := "scope"
--			scope_description := "description"
--			scope_name := "scope_name"
--			annotations.extend ("name=" + scope_name)
--			annotations.extend (scope)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("scopes set", target.known_scopes [scope_name].scopes [scope_description].same_string (scope))
--		end

--	test_tag_annotation
--		local
--			name: STRING
--			description: STRING
--			external_docs_name: STRING
--			external_doc: EXTERNAL_DOCUMENTATION_OBJECT
--		do
--			create external_doc.make
--			tag := "sa_tag"
--			name := "name"
--			description := "description"
--			external_docs_name := "external_docs"
--			target.known_external_docs.extend (external_doc, external_docs_name)
--			annotations.extend ("name=" + name)
--			annotations.extend ("description=" + description)
--			annotations.extend ("external_docs=" + external_docs_name)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("count not correct", target.swagger_object.tags.count = 1)
--			assert ("name not set", target.swagger_object.tags.first.name.same_string (name))
--			assert ("description not set", target.swagger_object.tags.first.description.same_string (description))
--			assert ("external_docs not set", target.swagger_object.tags.first.external_docs = external_doc)
--		end

--	test_external_doc_def_annotation
--		local
--			name, description, url: STRING
--		do
--			tag := "sa_external_doc_def"
--			name := "name"
--			description := "description"
--			url := "url"
--			annotations.extend ("name=" + name)
--			annotations.extend ("description=" + description)
--			annotations.extend ("url=" + url)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert ("description not set", target.swagger_object.external_docs.description.same_string (description))
--			assert ("url not set", target.swagger_object.external_docs.url.same_string (url))
--		end

--	test_external_doc_annotation
--		local
--			external_doc: EXTERNAL_DOCUMENTATION_OBJECT
--			external_doc_name: STRING
--		do
--			tag := "sa_external_doc"
--			external_doc_name := "name"
--			create external_doc.make
--			target.known_external_docs.extend (external_doc, external_doc_name)
--			annotations.extend (external_doc_name)
--			index := create_index_as (tag, annotations)
--			index.process (target)
--			assert("external_doc not set", target.swagger_object.external_docs = external_doc)
--		end

end
