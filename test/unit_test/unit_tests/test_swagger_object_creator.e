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
		end

	on_clean
			-- <Precursor>
		do
				--assert ("not_implemented", False)
		end

	create_index_as (tag: STRING; indexes: LINKED_LIST [STRING]): INDEX_AS
		local
			temp_e_list: EIFFEL_LIST [ATOMIC_AS]
		do
			create temp_e_list.make (indexes.count)
			across
				indexes as i
			loop
				temp_e_list.extend (create {STRING_AS}.initialize (i.item, 0, 0, 0, 0, 0, 0, 0))
			end
			create result.initialize (create {ID_AS}.initialize (tag), temp_e_list, create {SYMBOL_AS}.make (1, 1, 1, 1, 1, 1, 1, 1))
		end

	lists_contain_same_elements(l1, l2: LINKED_LIST[STRING]): BOOLEAN
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
				result := result and contains_string(s, l2)
			end
		end

	contains_string(s: STRING; l: LIST[STRING]): BOOLEAN
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
feature -- Test routines

	test_spec_annotation
			-- New test routine
		note
			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_swagger_spec"
		local
			index: INDEX_AS
			annotations: LINKED_LIST [STRING]
			tag: STRING
			swagger, host, base_path: STRING
		do
			create annotations.make
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
		local
			index: INDEX_AS
			annotations: LINKED_LIST [STRING]
			tag: STRING
		do
			create annotations.make
			tag := "sa_consumes"
			annotations.extend ("consume0")
			index := create_index_as (tag, annotations)
			target.process_index_as (index)
			assert("consumes not set", lists_contain_same_elements (annotations, target.swagger_object.consumes))
		end

	test_produces_annotation
		note
			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_list"
		local
			index: INDEX_AS
			annotations: LINKED_LIST [STRING]
			tag: STRING
		do
			create annotations.make
			tag := "sa_produces"
			annotations.extend ("produce0")
			index := create_index_as (tag, annotations)
			target.process_index_as (index)
			assert("produces not set", lists_contain_same_elements (annotations, target.swagger_object.produces))
		end

	test_schemes_annotation
		note
			testing: "covers/{SWAGGER_DOC_GENERATOR}.extract_list"
		local
			index: INDEX_AS
			annotations: LINKED_LIST [STRING]
			tag: STRING
		do
			create annotations.make
			tag := "sa_schemes"
			annotations.extend ("scheme0")
			index := create_index_as (tag, annotations)
			target.process_index_as (index)
			assert("scheme not set", lists_contain_same_elements (annotations, target.swagger_object.schemes))
		end

--	test_security_scheme_annotation
--		local
--			index: INDEX_AS
--			annotations: LINKED_LIST [STRING]
--			tag: STRING
--			type, description, name, in, flow, authorization_url, token_url, scope: STRING
--		do
--			create annotations.make
--			type := "type"
--			description := "description"
--			name := "name"
--			in := "in"
--			flow := "flow"
--			authorization_url := "authorization_url"
--			token_url := "token_url"
--			scope := "scope"
--			tag := sa_security_scheme
--			annotations.extend ("type=" + type)
--			annotations.extend ("description=" + description)
--			annotations.extend ("name=" + name)
--			annotations.extend ("in=" + in)
--			annotations.extend ("flow=" + flow)
--			annotations.extend ("authorization_url=" + authorization_url)
--			annotations.extend ("token_url=" + token_url)
--			annotations.extend ("scope=" + scope)
--			
--			assert ("type set", target.swagger_object.type.same_string (type))
--			assert ("description set", target.swagger_object.description.same_string (description))
--			assert ("name set", target.swagger_object.name.same_string (name))
--			assert ("in set", target.swagger_object.in.same_string (in))
--			assert ("flow set", target.swagger_object.flow.same_string (flow))
--			assert ("authorization_url set", target.swagger_object.authorization_url.same_string (authorization_url))
--			assert ("token_url set", target.swagger_object.token_url.same_string (token_url))
--			assert ("scope set", target.swagger_object.scope.same_string (scope))
--		end

end
