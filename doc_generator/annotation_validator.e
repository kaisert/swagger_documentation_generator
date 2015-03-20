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

feature

	validate_info_annotation (l_as: INDEX_AS): BOOLEAN
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
			Result := check_if_valid (l_as, allowed_fields, imposed_fields)
		end

	validate_spec_annotation (l_as: INDEX_AS): BOOLEAN
		do
			result := l_as.index_list.count = 1
		end

	validate_contact_annotation (l_as: INDEX_AS): BOOLEAN
		local
			allowed_fields: LINKED_LIST [STRING]
			imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("name")
			allowed_fields.extend ("url")
			allowed_fields.extend ("email")
			result := check_if_valid (l_as, allowed_fields, imposed_fields)
		end

	validate_license_annotation (l_as: INDEX_AS): BOOLEAN
		local
			allowed_fields: LINKED_LIST [STRING]
			imposed_fields: LINKED_LIST [STRING]
		do
			create allowed_fields.make
			create imposed_fields.make
			allowed_fields.extend ("name")
			allowed_fields.extend ("url")
			imposed_fields.extend ("name")
			result := check_if_valid (l_as, allowed_fields, imposed_fields)
		end

	validate_operation_annotation (l_as: INDEX_AS): BOOLEAN
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
			result := check_if_valid (l_as, allowed_fields, imposed_fields)
		end

	validate_operation_tags_annotation (l_as: INDEX_AS): BOOLEAN
		do
			result := l_as.index_list.count > 0
		end

	validate_operation_consumes_annotation (l_as: INDEX_AS): BOOLEAN
		do
			result := l_as.index_list.count > 0
		end

	validate_operation_produces_anntation (l_as: INDEX_AS): BOOLEAN
		do
			result := l_as.index_list.count > 0
		end

	validate_operation_schemes_anntation (l_as: INDEX_AS): BOOLEAN
		do
			result := l_as.index_list.count > 0
		end

	validate_operation_schema_anntation (l_as: INDEX_AS): BOOLEAN
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
			result := check_if_valid (l_as, allowed_fields, imposed_fields)
		end

	validate_operation_response_annotation (l_as: INDEX_AS): BOOLEAN
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
			result := check_if_valid (l_as, allowed_fields, imposed_fields)
		end

	validate_parameter_annotation (l_as: INDEX_AS): BOOLEAN
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
			result := check_if_valid (l_as, allowed_fields, imposed_fields)
			if result then
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
						result := result and allowed_fields.has (current_value)
						found_fields.extend (current_value)
					end
				end
				result := result and (is_body implies found_fields.has ("schema")) and (not is_body implies found_fields.has ("type"))
			end
			result := result and (is_array implies found_fields.has ("items"))
		end

end
