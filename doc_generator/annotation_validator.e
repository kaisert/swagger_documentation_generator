note
	description: "Summary description for {ANNOTATION_VALIDATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ANNOTATION_VALIDATOR

feature {NONE}

	check_if_valid (l_as: INDEX_AS; allowed_fields, imposed_fields: LINKED_LIST [STRING]): BOOLEAN
		local
			found_fields: LINKED_LIST [STRING]
			current_value: STRING
		do
			create found_fields.make
			result := true
			across
				l_as.index_list as indexes
			loop
				if attached {STRING_AS} indexes.item as item then
					current_value := item.value_32
					current_value := current_value.split ('=').first
					result := result and allowed_fields.has (current_value)
					found_fields.extend (current_value)
				end
			end
			across
				imposed_fields as fields
			loop
				result := result and found_fields.has (fields.item)
			end
		end

feature {ANNOTATION_VALIDATOR}

	error_msg: STRING

	error_found: BOOLEAN

feature {ANNOTATION_VALIDATOR}

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
			if not check_if_valid (l_as, allowed_fields, imposed_fields) then
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
			if not check_if_valid (l_as, allowed_fields, imposed_fields) then
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
			if not check_if_valid (l_as, allowed_fields, imposed_fields) then
				set_error_msg (l_as)
			end
		end

	validate_operation_annotation (l_as: INDEX_AS)
		local
			allowed_fields, imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("summary")
			allowed_fields.extend ("description")
			allowed_fields.extend ("externalDocs")
			allowed_fields.extend ("operationId")
			allowed_fields.extend ("parameters")
			allowed_fields.extend ("deprecated")
			allowed_fields.extend ("security")
			imposed_fields.extend ("response")
			if not check_if_valid (l_as, allowed_fields, imposed_fields) then
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
			allowed_fields.extend ("multipleOf")
			allowed_fields.extend ("maximum")
			allowed_fields.extend ("exclusiveMaximum")
			allowed_fields.extend ("minimum")
			allowed_fields.extend ("exclusiveMinimum")
			allowed_fields.extend ("maxLength")
			allowed_fields.extend ("minLength")
			allowed_fields.extend ("pattern")
			allowed_fields.extend ("maxItems")
			allowed_fields.extend ("minItems")
			allowed_fields.extend ("uniqueItems")
			allowed_fields.extend ("maxProperties")
			allowed_fields.extend ("minProperties")
			allowed_fields.extend ("required")
			allowed_fields.extend ("enum")
			allowed_fields.extend ("type")
			allowed_fields.extend ("items")
			allowed_fields.extend ("allOf")
			allowed_fields.extend ("properties")
			allowed_fields.extend ("discriminator")
			allowed_fields.extend ("readOnly")
			allowed_fields.extend ("xml")
			allowed_fields.extend ("externalDocs")
			allowed_fields.extend ("example")
			allowed_fields.extend ("consumes")
			allowed_fields.extend ("produces")
			allowed_fields.extend ("parameters")
			allowed_fields.extend ("responses")
			allowed_fields.extend ("schemes")
			allowed_fields.extend ("deprecated")
			allowed_fields.extend ("security")
			imposed_fields.extend ("name")
			if not check_if_valid (l_as, allowed_fields, imposed_fields) then
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
			if not check_if_valid (l_as, allowed_fields, imposed_fields) then
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
			allowed_fields.extend ("collectionFormat")
			allowed_fields.extend ("default")
			allowed_fields.extend ("maximum")
			allowed_fields.extend ("exclusiveMaximum")
			allowed_fields.extend ("minimum")
			allowed_fields.extend ("exclusiveMinimum")
			allowed_fields.extend ("maxLength")
			allowed_fields.extend ("minLength")
			allowed_fields.extend ("pattern")
			allowed_fields.extend ("maxItems")
			allowed_fields.extend ("minItems")
			allowed_fields.extend ("uniqueItems")
			allowed_fields.extend ("enum")
			allowed_fields.extend ("multipleOf")
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
		do
		end

	validate_security_requirement_annotation (l_as: INDEX_AS)
		do
		end

	validate_path_annotation (l_as: INDEX_AS)
		do
		end

	validate_header_annotation (l_as: INDEX_AS)
		do
		end

	validate_definition_annotation (l_as: INDEX_AS)
		do
		end

	validate_schema_annotation (l_as: INDEX_AS)
		do
		end

	validate_response_annotation (l_as: INDEX_AS)
		do
		end

	validate_security_scheme_annotation (l_as: INDEX_AS)
		do
		end

	validate_scope_annotation (l_as: INDEX_AS)
		do
		end

	validate_external_doc_annotation (l_as: INDEX_AS)
		do
		end

end
