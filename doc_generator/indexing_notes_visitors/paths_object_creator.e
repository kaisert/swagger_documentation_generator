note
	description: "Summary description for {PATHS_OBJECT_CREATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PATHS_OBJECT_CREATOR

inherit

	INDEXING_NOTES_VISITOR

create
	make

feature {NONE}

	class_indexes_handled: BOOLEAN

	current_base_path: STRING

	schemes: HASH_TABLE [SCHEMA_OBJECT, STRING]

	current_parameter: LINKED_LIST [PARAMETER_OBJECT]

	current_responses: RESPONSES_OBJECT

	current_refs: LINKED_LIST [REFERENCE_OBJECT]

	current_headers: HASH_TABLE [HEADER_OBJECT, STRING]

	current_operation: OPERATION_OBJECT

	current_tags: LINKED_LIST [STRING]

	current_consumes: LINKED_LIST [STRING]

	current_produces: LINKED_LIST [STRING]

	current_schemes: LINKED_LIST [STRING]

feature

	make
			-- initializes a new instance
		do
			class_indexes_handled := false
			create paths.make
			create current_parameter.make
			create current_headers.make (10)
			create schemes.make (10)
		end

feature

	paths: PATHS_OBJECT

	reset
			-- resets the visitor
		do
			class_indexes_handled := false
			create paths.make
			schemes.wipe_out
			current_parameter.wipe_out
			current_headers.wipe_out
		end

feature {NONE}

	extract_base_path (l_as: INDEX_AS)
		do
			if attached {STRING_AS} l_as.index_list.first as p then
				current_base_path := p.value_32.twin
			end
		end

	extract_schema (l_as: INDEX_AS)
		local
			schema: SCHEMA_OBJECT
			current_index: STRING
		do
			create schema.make
			if attached l_as.index_list as il then
				across
					il as index_list
				loop
					if attached {STRING_AS} index_list.item as index then
						current_index := index.value_32.twin
						if current_index.starts_with ("ref=") then
							current_index.replace_substring_all ("ref=", "")
							schema.set_ref (current_index)
						elseif current_index.starts_with ("name=") then
							current_index.replace_substring_all ("name=", "")
							schemes.extend (schema, current_index)
						elseif current_index.starts_with ("format=") then
							current_index.replace_substring_all ("format=", "")
							schema.set_format (current_index)
						elseif current_index.starts_with ("description=") then
							current_index.replace_substring_all ("description=", "")
							schema.set_description (current_index)
						elseif current_index.starts_with ("pattern=") then
							current_index.replace_substring_all ("pattern=", "")
							schema.set_pattern (current_index)
						elseif current_index.starts_with ("type=") then
							current_index.replace_substring_all ("type=", "")
							schema.set_type (current_index)
						elseif current_index.starts_with ("discriminator=") then
							current_index.replace_substring_all ("discriminator=", "")
							schema.set_discriminator (current_index)
						elseif current_index.starts_with ("multiple_of=") then
							current_index.replace_substring_all ("multiple_of=", "")
							schema.set_multiple_of (current_index.to_real)
						elseif current_index.starts_with ("maximum=") then
							current_index.replace_substring_all ("maximum=", "")
							schema.set_maximum (current_index.to_real)
						elseif current_index.starts_with ("minimum=") then
							current_index.replace_substring_all ("minimum=", "")
							schema.set_minimum (current_index.to_real)
						elseif current_index.starts_with ("exclusive_maximum=") then
							current_index.replace_substring_all ("exclusive_maximum=", "")
							schema.set_exclusivemaximum (current_index.to_boolean)
						elseif current_index.starts_with ("exclusive_minimum=") then
							current_index.replace_substring_all ("exclusive_minimum=", "")
							schema.set_exclusiveminimum (current_index.to_boolean)
						elseif current_index.starts_with ("unique_items=") then
							current_index.replace_substring_all ("unique_items=", "")
							schema.set_uniqueitems (current_index.to_boolean)
						elseif current_index.starts_with ("required=") then
							current_index.replace_substring_all ("required=", "")
							schema.set_required (current_index.to_boolean)
						elseif current_index.starts_with ("read_only=") then
							current_index.replace_substring_all ("reqd_only=", "")
							schema.set_read_only (current_index.to_boolean)
						elseif current_index.starts_with ("max_length=") then
							current_index.replace_substring_all ("max_length=", "")
							schema.set_maxlength (current_index.to_integer)
						elseif current_index.starts_with ("min_length=") then
							current_index.replace_substring_all ("min_length=", "")
							schema.set_minlength (current_index.to_integer)
						elseif current_index.starts_with ("min_items=") then
							current_index.replace_substring_all ("min_items=", "")
							schema.set_minitems (current_index.to_integer)
						elseif current_index.starts_with ("max_items=") then
							current_index.replace_substring_all ("max_items=", "")
							schema.set_maxitems (current_index.to_integer)
						elseif current_index.starts_with ("max_properties=") then
							current_index.replace_substring_all ("max_properties=", "")
							schema.set_maxproperties (current_index.to_integer)
						elseif current_index.starts_with ("min_properties=") then
							current_index.replace_substring_all ("min_properties=", "")
							schema.set_minproperties (current_index.to_integer)
								--TODO: default_value
								--		enum
								--		xml
								--		external_doc
								--		example
						end
					end
				end
			end
		end

	extract_parameter (l_as: INDEX_AS)
		local
			is_body_parameter: BOOLEAN
			parameter_body: PARAMETER_BODY_OBJECT
			parameter_other: PARAMETER_OTHER_OBJECT
			name, in, schema_name, current_value, description: STRING
			is_required: BOOLEAN
		do
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_value := index.value_32.twin
					if current_value.starts_with ("name=") then
						current_value.replace_substring_all ("name=", "")
						name := current_value
					elseif current_value.starts_with ("in=") then
						is_body_parameter := index.value_32.same_string ("in=body")
						current_value.replace_substring_all ("in=", "")
						in := current_value
					elseif current_value.starts_with ("schema=") then
						current_value.replace_substring_all ("schema=", "")
						schema_name := current_value
					elseif current_value.starts_with ("required=") then
						current_value.replace_substring_all ("required=", "")
						is_required := current_value.to_boolean
					elseif current_value.starts_with ("description=") then
						current_value.replace_substring_all ("description=", "")
						description := current_value
							--TODO: non-body parameter
					end
				end
			end
			if is_body_parameter then
				create parameter_body.make
				parameter_body.set_name (name)
				parameter_body.set_in (in)
				parameter_body.set_required (is_required)
				parameter_body.set_schema (schemes.at (schema_name))
				parameter_body.set_descrption (description)
				current_parameter.extend (parameter_body)
			else
					--TODO: non-body parameter
			end
		end

	extract_response (l_as: INDEX_AS)
		local
			current_value, status_code: STRING
			response: RESPONSE_OBJECT
		do
			status_code := "default"
			across
				l_as.index_list as index_list
			loop
				create response.make
				if attached {STRING_AS} index_list.item as index then
					current_value := index.value_32.twin
					if current_value.starts_with ("description=") then
						current_value.replace_substring_all ("description=", "")
						response.set_description (current_value)
					elseif current_value.starts_with ("schema=") then
						current_value.replace_substring_all ("schema=", "")
						response.set_schema (schemes.at (current_value))
					elseif current_value.starts_with ("header=") then
						current_value.replace_substring_all ("header=", "")
						if response.headers = void then
							response.set_headers (create {HEADERS_OBJECT}.make)
						end
							--	response.headers.add_header (current_headers.at (current_value))
							--TODO: example object
					elseif current_value.starts_with ("status_code=") then
						current_value.replace_substring_all ("status_code=", "")
						status_code := current_value
					end
				end
			end
			current_responses.responses.extend (response, status_code)
		end

	extract_header (l_as: INDEX_AS)
		local
			current_index: STRING
			header: HEADER_OBJECT
		do
			create header.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_index := index.value_32.twin
					if current_index.starts_with ("type=") then
						current_index.replace_substring_all ("type=", "")
						header.set_type (current_index)
					elseif current_index.starts_with ("format=") then
						current_index.replace_substring_all ("format=", "")
						header.set_format (current_index)
					elseif current_index.starts_with ("collection_format=") then
						current_index.replace_substring_all ("collection_format=", "")
						header.set_format (current_index)
					elseif current_index.starts_with ("maximum=") then
						current_index.replace_substring_all ("maximum=", "")
						header.set_maximum (current_index.to_real)
					elseif current_index.starts_with ("minimum=") then
						current_index.replace_substring_all ("minimum=", "")
						header.set_minimum (current_index.to_real)
					elseif current_index.starts_with ("exclusive_maximum=") then
						current_index.replace_substring_all ("exclusive_maximum=", "")
						header.set_exclusive_maximum (current_index.to_boolean)
					elseif current_index.starts_with ("exclusive_minimum=") then
						current_index.replace_substring_all ("exclusive_minimum=", "")
						header.set_exclusive_minimum (current_index.to_boolean)
					elseif current_index.starts_with ("min_items=") then
						current_index.replace_substring_all ("min_items=", "")
						header.set_min_items (current_index.to_integer)
					elseif current_index.starts_with ("max_items=") then
						current_index.replace_substring_all ("max_items=", "")
						header.set_max_items (current_index.to_integer)
					elseif current_index.starts_with ("unique_items=") then
						current_index.replace_substring_all ("unique_items=", "")
						header.set_unique_items (current_index.to_boolean)
					elseif current_index.starts_with ("multiple_of=") then
						current_index.replace_substring_all ("multiple_of=", "")
						header.set_multiple_of (current_index.to_real)
							--TODO: enum
							--		default_value
							--		items
					end
				end
			end
		end

	extract_operation (l_as: INDEX_AS)
		local
			current_index: STRING
			path: STRING
		do
			path := ""
			create current_operation.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_index := index.value_32.twin
					if current_index.starts_with ("operation=") then
						current_index.replace_substring_all ("operation=", "")
						current_operation.set_operation (current_index)
					elseif current_index.starts_with ("summary=") then
						current_index.replace_substring_all ("summary=", "")
						current_operation.set_summary (current_index)
					elseif current_index.starts_with ("description=") then
						current_index.replace_substring_all ("description=", "")
						current_operation.set_description (current_index)
					elseif current_index.starts_with ("operation_id=") then
						current_index.replace_substring_all ("operation_id=", "")
						current_operation.set_operation_id (current_index)
					elseif current_index.starts_with ("deprecated=") then
						current_index.replace_substring_all ("deprecated=", "")
						current_operation.set_deprecated (current_index.to_boolean)
					elseif current_index.starts_with ("path=") then
						current_index.replace_substring_all ("path=", "")
						path := current_index
					end
				end
			end
			path := current_base_path + path
			if not paths.paths.has (path) then
				paths.paths.extend (create {PATH_ITEM_OBJECT}.make, path)
			end
			if current_operation.operation.same_string ("get") then
				paths.paths.at (path).set_get (current_operation)
			elseif current_operation.operation.same_string ("put") then
				paths.paths.at (path).set_put (current_operation)
			elseif current_operation.operation.same_string ("post") then
				paths.paths.at (path).set_post (current_operation)
			elseif current_operation.operation.same_string ("delete") then
				paths.paths.at (path).set_delete (current_operation)
			elseif current_operation.operation.same_string ("options") then
				paths.paths.at (path).set_options (current_operation)
			elseif current_operation.operation.same_string ("head") then
				paths.paths.at (path).set_head (current_operation)
			elseif current_operation.operation.same_string ("patch") then
				paths.paths.at (path).set_patch (current_operation)
			end
		end

	extract_tags (l_as: INDEX_AS)
		do
			create current_tags.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_tags.extend (index.value_32.twin)
				end
			end
		end

	extract_consumes (l_as: INDEX_AS)
		do
			create current_consumes.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_consumes.extend (index.value_32.twin)
				end
			end
		end

	extract_produces (l_as: INDEX_AS)
		do
			create current_produces.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_produces.extend (index.value_32.twin)
				end
			end
		end

	extract_schemes (l_as: INDEX_AS)
		do
			create current_schemes.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_schemes.extend (index.value_32.twin)
				end
			end
		end

feature
	-- visitor

	process_class_as (l_as: CLASS_AS)
		do
			current_class := l_as
			if attached l_as.top_indexes as indexes then
				indexes.process (current)
			end
			class_indexes_handled := true
			if attached l_as.features as f then
				across
					f as features
				loop
					current_base_path := ""
					features.item.process (current)
				end
			end
		end

	process_feature_as (l_as: FEATURE_AS)
		do
			if attached l_as.indexes as indexes then
--				across
--					l_as.indexes as indexes
--				loop
					current_tags := void
					current_consumes := void
					current_produces := void
					current_schemes := void
					indexes.process (current)
					current_operation.set_tags (current_tags)
					current_operation.set_consumes (current_consumes)
					current_operation.set_produces (current_produces)
					current_operation.set_schemes (current_schemes)
--				end
			end
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		do
			if attached l_as.features then
				across
					l_as.features as features
				loop
					features.item.process (current)
				end
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		do
			if class_indexes_handled then
				create current_responses.make
			end
			across
				l_as as indexes
			loop
				indexes.item.process (current)
			end
			if class_indexes_handled then
				current_operation.set_responses (current_responses)
			end
		end

	process_index_as (l_as: INDEX_AS)
		local
			tag: STRING
		do
			tag := l_as.tag.string_value_32
			if class_indexes_handled then
				if tag.same_string ("sa_schema") then
					extract_schema (l_as)
				elseif tag.same_string ("sa_parameter") then
					extract_parameter (l_as)
				elseif tag.same_string ("sa_response") then
					extract_response (l_as)
				elseif tag.same_string ("sa_header") then
					extract_header (l_as)
				elseif tag.same_string ("sa_operation") then
					extract_operation (l_as)
				elseif tag.same_string ("sa_operation_tags") then
					extract_tags (l_as)
				elseif tag.same_string ("sa_operation_consumes") then
					extract_consumes (l_as)
				elseif tag.same_string ("sa_operation_produces") then
					extract_produces (l_as)
				elseif tag.same_string ("sa_operation_schemes") then
					extract_schemes (l_as)
				end
					--TODO: externalDocs
					-- 		security
			else
				if tag.same_string ("sa_path") then
					extract_base_path (l_as)
				end
			end
		end

end
