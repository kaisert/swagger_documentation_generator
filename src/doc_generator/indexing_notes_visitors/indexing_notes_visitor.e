note
	description: "Summary description for {INDEXING_NOTES_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INDEXING_NOTES_VISITOR

inherit

	AST_NULL_VISITOR
		undefine
			process_index_as,
			process_class_as,
			process_feature_as,
			process_feature_clause_as,
			process_indexing_clause_as
		end

feature

	match_list: LEAF_AS_LIST

	set_match_list (a_match_list: LEAF_AS_LIST)
		do
			match_list := a_match_list
		end

feature

	process_classes (classes: LINKED_LIST [CLASS_AS])
		do
			across
				classes as c
			loop
				c.item.process (current)
			end
		end

feature {INDEXING_NOTES_VISITOR}

	current_class: CLASS_AS

	current_headers: HEADERS_OBJECT

	known_schemes: HASH_TABLE [SCHEMA_OBJECT, STRING]

	known_headers: HASH_TABLE [HEADER_OBJECT, STRING]

	known_external_docs: HASH_TABLE [EXTERNAL_DOCUMENTATION_OBJECT, STRING]

feature {INDEXING_NOTES_VISITOR}

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

	extract_schema (l_as: INDEX_AS): TUPLE [s: STRING; so: SCHEMA_OBJECT]
		local
			current_index: STRING
		do
			create result.default_create
			result.so := create {SCHEMA_OBJECT}.make
			if attached l_as.index_list as il then
				across
					il as index_list
				loop
					if attached {STRING_AS} index_list.item as index then
						current_index := index.value_32.twin
						if current_index.starts_with ("ref=") then
							current_index.replace_substring_all ("ref=", "")
							result.so.set_ref (current_index)
						elseif current_index.starts_with ("name=") then
							current_index.replace_substring_all ("name=", "")
							result.s := current_index
						elseif current_index.starts_with ("format=") then
							current_index.replace_substring_all ("format=", "")
							result.so.set_format (current_index)
						elseif current_index.starts_with ("description=") then
							current_index.replace_substring_all ("description=", "")
							result.so.set_description (current_index)
						elseif current_index.starts_with ("pattern=") then
							current_index.replace_substring_all ("pattern=", "")
							result.so.set_pattern (current_index)
						elseif current_index.starts_with ("type=") then
							current_index.replace_substring_all ("type=", "")
							result.so.set_type (current_index)
						elseif current_index.starts_with ("discriminator=") then
							current_index.replace_substring_all ("discriminator=", "")
							result.so.set_discriminator (current_index)
						elseif current_index.starts_with ("multiple_of=") then
							current_index.replace_substring_all ("multiple_of=", "")
							result.so.set_multiple_of (current_index.to_real)
						elseif current_index.starts_with ("maximum=") then
							current_index.replace_substring_all ("maximum=", "")
							result.so.set_maximum (current_index.to_real)
						elseif current_index.starts_with ("minimum=") then
							current_index.replace_substring_all ("minimum=", "")
							result.so.set_minimum (current_index.to_real)
						elseif current_index.starts_with ("exclusive_maximum=") then
							current_index.replace_substring_all ("exclusive_maximum=", "")
							result.so.set_exclusivemaximum (current_index.to_boolean)
						elseif current_index.starts_with ("exclusive_minimum=") then
							current_index.replace_substring_all ("exclusive_minimum=", "")
							result.so.set_exclusiveminimum (current_index.to_boolean)
						elseif current_index.starts_with ("unique_items=") then
							current_index.replace_substring_all ("unique_items=", "")
							result.so.set_uniqueitems (current_index.to_boolean)
						elseif current_index.starts_with ("required=") then
							current_index.replace_substring_all ("required=", "")
							result.so.set_required (current_index.to_boolean)
						elseif current_index.starts_with ("read_only=") then
							current_index.replace_substring_all ("reqd_only=", "")
							result.so.set_read_only (current_index.to_boolean)
						elseif current_index.starts_with ("max_length=") then
							current_index.replace_substring_all ("max_length=", "")
							result.so.set_maxlength (current_index.to_integer)
						elseif current_index.starts_with ("min_length=") then
							current_index.replace_substring_all ("min_length=", "")
							result.so.set_minlength (current_index.to_integer)
						elseif current_index.starts_with ("min_items=") then
							current_index.replace_substring_all ("min_items=", "")
							result.so.set_minitems (current_index.to_integer)
						elseif current_index.starts_with ("max_items=") then
							current_index.replace_substring_all ("max_items=", "")
							result.so.set_maxitems (current_index.to_integer)
						elseif current_index.starts_with ("max_properties=") then
							current_index.replace_substring_all ("max_properties=", "")
							result.so.set_maxproperties (current_index.to_integer)
						elseif current_index.starts_with ("min_properties=") then
							current_index.replace_substring_all ("min_properties=", "")
							result.so.set_minproperties (current_index.to_integer)
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

	extract_response (l_as: INDEX_AS): TUPLE [s: STRING; r: RESPONSE_OBJECT]
		local
			current_value, status_code: STRING
		do
			status_code := "default"
			create result.default_create
			result.r := create {RESPONSE_OBJECT}.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_value := index.value_32.twin
					if current_value.starts_with ("description=") then
						current_value.replace_substring_all ("description=", "")
						result.r.set_description (current_value)
					elseif current_value.starts_with ("schema=") then
						current_value.replace_substring_all ("schema=", "")
						result.r.set_schema (known_schemes.at (current_value))
					elseif current_value.starts_with ("header=") then
						current_value.replace_substring_all ("header=", "")
						if result.r.headers = void then
							result.r.set_headers (create {HEADERS_OBJECT}.make)
						end
						result.r.headers.headers.extend (known_headers.at (current_value), current_value)
							--TODO: example object
					elseif current_value.starts_with ("status_code=") then
						current_value.replace_substring_all ("status_code=", "")
						result.s := current_value
					end
				end
			end
		end

	extract_header (l_as: INDEX_AS): TUPLE [s: STRING; h: HEADER_OBJECT]
		local
			current_index: STRING
		do
			create result.default_create
			result.h := create {HEADER_OBJECT}.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_index := index.value_32.twin
					if current_index.starts_with ("type=") then
						current_index.replace_substring_all ("type=", "")
						result.h.set_type (current_index)
					elseif current_index.starts_with ("format=") then
						current_index.replace_substring_all ("format=", "")
						result.h.set_format (current_index)
					elseif current_index.starts_with ("collection_format=") then
						current_index.replace_substring_all ("collection_format=", "")
						result.h.set_format (current_index)
					elseif current_index.starts_with ("maximum=") then
						current_index.replace_substring_all ("maximum=", "")
						result.h.set_maximum (current_index.to_real)
					elseif current_index.starts_with ("minimum=") then
						current_index.replace_substring_all ("minimum=", "")
						result.h.set_minimum (current_index.to_real)
					elseif current_index.starts_with ("exclusive_maximum=") then
						current_index.replace_substring_all ("exclusive_maximum=", "")
						result.h.set_exclusive_maximum (current_index.to_boolean)
					elseif current_index.starts_with ("exclusive_minimum=") then
						current_index.replace_substring_all ("exclusive_minimum=", "")
						result.h.set_exclusive_minimum (current_index.to_boolean)
					elseif current_index.starts_with ("min_items=") then
						current_index.replace_substring_all ("min_items=", "")
						result.h.set_min_items (current_index.to_integer)
					elseif current_index.starts_with ("max_items=") then
						current_index.replace_substring_all ("max_items=", "")
						result.h.set_max_items (current_index.to_integer)
					elseif current_index.starts_with ("unique_items=") then
						current_index.replace_substring_all ("unique_items=", "")
						result.h.set_unique_items (current_index.to_boolean)
					elseif current_index.starts_with ("multiple_of=") then
						current_index.replace_substring_all ("multiple_of=", "")
						result.h.set_multiple_of (current_index.to_real)
					elseif current_index.starts_with ("name=") then
						current_index.replace_substring_all ("name=", "")
						result.s := current_index
							--TODO: enum
							--		default_value
							--		items
					end
				end
			end
		end

	extract_parameter (l_as: INDEX_AS): TUPLE [s: STRING; p: PARAMETER_OBJECT]
		local
			is_body_parameter: BOOLEAN
			parameter_body: PARAMETER_BODY_OBJECT
			parameter_other: PARAMETER_OTHER_OBJECT
			name, in, schema_name, current_value, description: STRING
			is_required: BOOLEAN
		do
			create Result.default_create
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_value := index.value_32.twin
					if current_value.starts_with ("name=") then
						current_value.replace_substring_all ("name=", "")
						result.s := current_value
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
				parameter_body.set_schema (known_schemes.at (schema_name))
				parameter_body.set_descrption (description)
				result.p := parameter_body
			else
					--TODO: non-body parameter
			end
		end

	extract_external_doc_def (l_as: INDEX_AS): TUPLE [s: STRING; ed: EXTERNAL_DOCUMENTATION_OBJECT]
		local
			current_index: STRING
		do
			create Result.default_create
			result.ed := create {EXTERNAL_DOCUMENTATION_OBJECT}.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as s then
					current_index.copy (s.value_32)
				end
				if current_index.starts_with ("name=") then
					current_index.replace_substring_all ("name=", "")
					result.s := current_index
				elseif current_index.starts_with ("description=") then
					current_index.replace_substring_all ("description=", "")
					result.ed.set_description (current_index)
				elseif current_index.starts_with ("url=") then
					current_index.replace_substring_all ("url=", "")
					result.ed.set_url (current_index)
				end
			end
		end

	extract_security_requirement (l_as: INDEX_AS): SECURITY_REQUIREMENT_OBJECT
		local
			field_value_pair: LIST [STRING]
			current_index: STRING
		do
			create Result.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as s then
					current_index.copy (s.value_32)
				end
				if current_index.starts_with ("name=") then
					field_value_pair := current_index.split ('=')
					result.set_field (field_value_pair.at (1))
				else
					result.values.extend (current_index)
				end
			end
		end

feature
	-- visitor implementation

	process_class_as (l_as: CLASS_AS)
		deferred
		end

	process_feature_as (l_as: FEATURE_AS)
		deferred
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		deferred
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		deferred
		end

	process_index_as (l_as: INDEX_AS)
		deferred
		end

end
