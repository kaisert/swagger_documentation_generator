note
	description: "Summary description for {SWAGGER_OBJECT_CREATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SWAGGER_OBJECT_CREATOR

inherit

	INDEXING_NOTES_VISITOR

create
	make

feature

	make
			--initializes a new instance
		do
			create info_visitor
			create paths_visitor.make
			create known_schemes.make (10)
		end

feature {NONE}

	info_visitor: INFO_OBJECT_CREATOR

	paths_visitor: PATHS_OBJECT_CREATOR

	definitions: DEFINITIONS_OBJECT

		--known_schemes: HASH_TABLE[SCHEMA_OBJECT, STRING]

feature

	swagger_object: SWAGGER_OBJECT

feature {NONE}

	extract_swagger_spec (l_as: INDEX_AS)
			-- extracts the swagger specification
		local
			current_index: STRING
		do
			current_index := ""
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as s then
					current_index.copy (s.value_32)
				end
				if current_index.starts_with ("swagger=") then
					current_index.replace_substring_all ("swagger=", "")
					swagger_object.set_swagger (current_index.twin)
				elseif current_index.starts_with ("host=") then
					current_index.replace_substring_all ("host=", "")
					swagger_object.set_host (current_index.twin)
				elseif current_index.starts_with ("base_path=") then
					current_index.replace_substring_all ("base_path=", "")
					swagger_object.set_base_path (current_index.twin)
				end
			end
		end

	extract_list (l_as: INDEX_AS; list: LINKED_LIST [STRING])
		do
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as s then
					list.extend (s.value_32.twin)
				end
			end
		end

		--	extract_definition(l_as)
		--		do
		--
		--		end

feature

	create_swagger_object (classes: LINKED_LIST [CLASS_AS])
		do
			create swagger_object.make
			across
				classes as c
			loop
				c.item.process (current)
			end
			across
				classes as c
			loop
				c.item.process (paths_visitor)
			end
			swagger_object.set_info (info_visitor.info)
			swagger_object.set_paths (paths_visitor.paths)
		end

feature
	--visitor

	process_class_as (l_as: CLASS_AS)
		do
			current_class := l_as
			l_as.top_indexes.process (current)
		end

	process_feature_as (l_as: FEATURE_AS)
		do
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		do
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		do
			across
				l_as as indexes
			loop
				indexes.item.process (current)
			end
		end

		--visitor

	process_index_as (l_as: INDEX_AS)
		local
			annotation: STRING
			schema: TUPLE [s: STRING; so: SCHEMA_OBJECT]
			parameter: TUPLE [s: STRING; p: PARAMETER_OBJECT]
			response: TUPLE [s: STRING; r: RESPONSE_OBJECT]
			header: TUPLE [s: STRING; h: HEADER_OBJECT]
		do
			annotation := l_as.tag.name_32
			if annotation.same_string ("sa_spec") then
				extract_swagger_spec (l_as)
			elseif annotation.same_string ("sa_info") then
				current_class.process (info_visitor)
			elseif annotation.same_string ("sa_consumes") then
				swagger_object.set_consumes (create {LINKED_LIST [STRING]}.make)
				extract_list (l_as, swagger_object.consumes)
			elseif annotation.same_string ("sa_produces") then
				swagger_object.set_produces (create {LINKED_LIST [STRING]}.make)
				extract_list (l_as, swagger_object.produces)
			elseif annotation.same_string ("sa_schemes") then
				swagger_object.set_scheme (create {LINKED_LIST [STRING]}.make)
				extract_list (l_as, swagger_object.schemes)
			elseif annotation.same_string ("sa_definition") then
				if not attached swagger_object.definitions then
					swagger_object.set_definitions (create {DEFINITIONS_OBJECT}.make)
					schema := extract_schema (l_as)
					swagger_object.definitions.definitions.extend (schema.so, schema.s)
				end
			elseif annotation.same_string ("sa_schema") then
				schema := extract_schema (l_as)
				known_schemes.extend (schema.so, schema.s)
			elseif annotation.same_string ("sa_header") then
				header := extract_header (l_as)
				known_headers.extend (header.h, header.s)
			elseif annotation.same_string ("sa_response") then
				if not attached swagger_object.responses then
					swagger_object.set_responses (create {RESPONSES_DEFINITIONS_OBJECT}.make)
					response := extract_response (l_as)
					swagger_object.responses.responses.extend (response.r, response.s)
				end
			elseif annotation.same_string ("sa_parameter") then
				if not attached swagger_object.parameters then
					swagger_object.set_parameters (create {PARAMETERS_DEFINITIONS_OBJECT}.make)
				end
				parameter := extract_parameter (l_as)
				swagger_object.parameters.parameters.extend (parameter.p, parameter.s)
			end
		end

end
