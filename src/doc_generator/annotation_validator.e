note
	description: "Summary description for {ANNOTATION_VALIDATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ANNOTATION_VALIDATOR

feature {NONE}



	there_exists (list: LIST[STRING]; test: PREDICATE [ANY, TUPLE [STRING]]): BOOLEAN
			-- own implementation of 'there_exists' of class LINEAR
			-- since an agent of type FUNCTION[ANY, TUPLE[G], BOOLEAN] gets interpreted
			-- as PREDICATE[ANY, TUPLE[G]] the call causes a cat-call every time.
			-- might be a optimization issue during compilation, but kinda strange
			-- that things like that occur. Was that even tested before?
		require -- from TRAVERSABLE
			test_exists: test /= Void
			list_exists: list /= Void
		do
			result := false
			across
				list as l
			loop
				result := result or test.item ([l.item])
			end
		end

	are_same_string(a,b: STRING): BOOLEAN
		do
			result := a.same_string (b)
		end

	is_valid_type (l_as: INDEX_AS): BOOLEAN
		do
			result := true
			across
				l_as.index_list as index_list
			loop
				result := result and (attached {STRING_AS} index_list.item)
			end
		end

	do_fields_exist (l_as: INDEX_AS; imposed_fields: LINKED_LIST [STRING]): BOOLEAN
		local
			found_fields: LINKED_LIST [STRING]
			field_value_pair: LIST[STRING_32]
			intermediate_result: BOOLEAN
		do
			result := true
			create found_fields.make
			across
				l_as.index_list as indexes
			loop
				if attached {STRING_AS} indexes.item as item then
					field_value_pair := item.value_32.split('=')
					found_fields.extend (field_value_pair.first)
				end
			end
			across
				imposed_fields as fields
			loop
				intermediate_result := there_exists (found_fields, agent are_same_string(fields.item, ?))
				if not intermediate_result then
					missing_field := fields.item
				end
				result := result and intermediate_result
			end
			if result then
				missing_field := Void
			end
		end

	is_valid_annotation (l_as: INDEX_AS; allowed_fields, imposed_fields: LINKED_LIST [STRING]): BOOLEAN
		local
			found_fields: LINKED_LIST [STRING]
			current_value: STRING
			intermediate_result: BOOLEAN
		do
			create found_fields.make
			valid_type := is_valid_type (l_as)
			result := valid_type
			across
				l_as.index_list as indexes
			loop
				if attached {STRING_AS} indexes.item as item then
					current_value := item.value_32
					current_value := current_value.split ('=').first
					intermediate_result := there_exists(allowed_fields, agent are_same_string(current_value, ?))
					result := result and intermediate_result
					if not intermediate_result then
						wrong_attribute := current_value
					end
					found_fields.extend (current_value)
				end
			end
			result := result and do_fields_exist (l_as, imposed_fields)
			if result then
				wrong_attribute := void
			end
		end

feature {ANNOTATION_VALIDATOR}

	error_msg: STRING

	error_found, valid_type: BOOLEAN

feature {ANNOTATION_VALIDATOR}

	wrong_attribute, missing_field: STRING

	set_error_msg (l_as: INDEX_AS)
		deferred
		end

	validate_info_annotation (l_as: INDEX_AS)
		local
			allowed_fields: LINKED_LIST [STRING]
			imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("title")
			allowed_fields.extend ("description")
			allowed_fields.extend ("termsOfService")
			allowed_fields.extend ("version")
			imposed_fields.extend ("title")
			imposed_fields.extend ("version")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_spec_annotation (l_as: INDEX_AS)
		do
			if not (l_as.index_list.count = 1) then
				set_error_msg (l_as)
			end
		end

	validate_contact_annotation (l_as: INDEX_AS)
		local
			allowed_fields: LINKED_LIST [STRING]
			imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("name")
			allowed_fields.extend ("url")
			allowed_fields.extend ("email")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_license_annotation (l_as: INDEX_AS)
		local
			allowed_fields: LINKED_LIST [STRING]
			imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("name")
			allowed_fields.extend ("url")
			imposed_fields.extend ("name")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_operation_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("operation")
			allowed_fields.extend ("summary")
			allowed_fields.extend ("description")
			allowed_fields.extend ("externalDocs")
			allowed_fields.extend ("operationId")
			allowed_fields.extend ("parameters")
			allowed_fields.extend ("deprecated")
			allowed_fields.extend ("security")
			allowed_fields.extend ("path")
			allowed_fields.extend ("operation_id")
			imposed_fields.extend ("operation")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_list_annotation (l_as: INDEX_AS)
		do
			if not (l_as.index_list.count > 0) then
				set_error_msg (l_as)
			end
		end

	validate_operation_schema_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("name")
			allowed_fields.extend ("ref")
			allowed_fields.extend ("format")
			allowed_fields.extend ("title")
			allowed_fields.extend ("description")
			allowed_fields.extend ("default")
			allowed_fields.extend ("multiple_of")
			allowed_fields.extend ("maximum")
			allowed_fields.extend ("exclusive_maximum")
			allowed_fields.extend ("minimum")
			allowed_fields.extend ("exclusive_minimum")
			allowed_fields.extend ("max_length")
			allowed_fields.extend ("min_length")
			allowed_fields.extend ("pattern")
			allowed_fields.extend ("max_items")
			allowed_fields.extend ("min_items")
			allowed_fields.extend ("unique_items")
			allowed_fields.extend ("max_properties")
			allowed_fields.extend ("min_properties")
			allowed_fields.extend ("required")
			allowed_fields.extend ("enum")
			allowed_fields.extend ("type")
			allowed_fields.extend ("items")
			allowed_fields.extend ("allOf")
			allowed_fields.extend ("properties")
			allowed_fields.extend ("discriminator")
			allowed_fields.extend ("readOnly")
			allowed_fields.extend ("xml")
			allowed_fields.extend ("external_docs")
			allowed_fields.extend ("example")
			allowed_fields.extend ("consumes")
			allowed_fields.extend ("produces")
			allowed_fields.extend ("parameters")
			allowed_fields.extend ("responses")
			allowed_fields.extend ("schemes")
			allowed_fields.extend ("deprecated")
			allowed_fields.extend ("security")
			imposed_fields.extend ("name")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_operation_response_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("description")
			allowed_fields.extend ("schema")
			allowed_fields.extend ("header")
			allowed_fields.extend ("examples")
			imposed_fields.extend ("description")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_parameter_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields, found_fields: LINKED_LIST [STRING]
			is_body, is_array: BOOLEAN
			current_value: STRING
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("name")
			allowed_fields.extend ("in")
			allowed_fields.extend ("description")
			allowed_fields.extend ("required")
			allowed_fields.extend ("schema")
			allowed_fields.extend ("type")
			allowed_fields.extend ("format")
			allowed_fields.extend ("items")
			allowed_fields.extend ("collection_format")
			allowed_fields.extend ("default")
			allowed_fields.extend ("maximum")
			allowed_fields.extend ("exclusive_maximum")
			allowed_fields.extend ("minimum")
			allowed_fields.extend ("exclusive_minimum")
			allowed_fields.extend ("max_length")
			allowed_fields.extend ("min_length")
			allowed_fields.extend ("pattern")
			allowed_fields.extend ("max_items")
			allowed_fields.extend ("min_items")
			allowed_fields.extend ("unique_items")
			allowed_fields.extend ("enum")
			allowed_fields.extend ("multiple_of")
			imposed_fields.extend ("name")
			imposed_fields.extend ("in")
			imposed_fields.extend ("required")
				--result := check_if_valid (l_as, allowed_fields, imposed_fields)
				--if result then
			is_body := false
			across
				l_as.index_list as indexes
			loop
				if attached {STRING_AS} indexes.item as item then
					current_value := item.value_32
					current_value := current_value.split ('=').first
					if current_value.split ('=').first.same_string ("in") then
						is_body := is_body or current_value.split ('=').at (1).same_string ("body")
					elseif current_value.split ('=').first.same_string ("type") then
						is_array := current_value.split ('=').at (1).same_string ("array")
					end
						--result := result and allowed_fields.has (current_value)
					found_fields.extend (current_value)
				end
					--end
					-- TODO
					--result := result and (is_body implies found_fields.has ("schema")) and (not is_body implies found_fields.has ("type"))
			end
				--result := result and (is_array implies found_fields.has ("items"))
		end

	validate_base_path_annotation (l_as: INDEX_AS)
		do
			if not (l_as.index_list.count = 1) then
				set_error_msg (l_as)
			end
		end

	validate_external_doc_def_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("name")
			allowed_fields.extend ("description")
			allowed_fields.extend ("url")
			imposed_fields.extend ("name")
			imposed_fields.extend ("url")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_security_requirement_annotation (l_as: INDEX_AS)
		local
			imposed_fields: LINKED_LIST [STRING]
		do
			create imposed_fields.make
			imposed_fields.extend ("name")
			if not do_fields_exist (l_as, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_path_annotation (l_as: INDEX_AS)
		do
			if not (l_as.index_list.count = 1) then
				set_error_msg (l_as)
			end
		end

	validate_header_annotation (l_as: INDEX_AS)
		do
				--TODO
		end

	validate_definition_annotation (l_as: INDEX_AS)
		do
			validate_schema_annotation (l_as)
		end

	validate_schema_annotation (l_as: INDEX_AS)
		do
				--TODO
		end

	validate_response_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("description")
			allowed_fields.extend ("schema")
			allowed_fields.extend ("header")
			allowed_fields.extend ("status_code")
			imposed_fields.extend ("description")
			imposed_fields.extend ("status_code")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_security_scheme_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("type")
			allowed_fields.extend ("description")
			allowed_fields.extend ("name")
			allowed_fields.extend ("in")
			allowed_fields.extend ("flow")
			allowed_fields.extend ("authorization_url")
			allowed_fields.extend ("token_url")
			allowed_fields.extend ("scopes")
			imposed_fields.extend ("type")
			imposed_fields.extend ("name")
			imposed_fields.extend ("in")
			imposed_fields.extend ("flow")
			imposed_fields.extend ("authorization_url")
			imposed_fields.extend ("token_url")
			imposed_fields.extend ("scopes")
			if not is_valid_annotation (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_scope_annotation (l_as: INDEX_AS)
		do
		end

	validate_external_doc_annotation (l_as: INDEX_AS)
		do
		end

end
