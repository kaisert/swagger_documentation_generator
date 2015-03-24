note
	description: "Summary description for {JSON_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_GENERATOR

inherit

	SWAGGER_VISITOR

feature {NONE}

	intermediate_result: JSON_VALUE_OBJECT

	create_json_string_array (list: detachable LIST [STRING]): detachable JSON_ARRAY [JSON_VALUE_OBJECT]
		do
			if attached list as l then
				create result.make
				across
					l as ll
				loop
					Result.value.extend (create {JSON_STRING}.make (ll.item))
				end
			end
		end

	create_json_object_array (list: detachable LIST [SWAGGER_API_OBJECT]): detachable JSON_ARRAY [JSON_VALUE_OBJECT]
		do
			if attached list as l then
				create Result.make
				across
					l as ll
				loop
					ll.item.process (current)
					Result.value.extend (intermediate_result)
				end
			end
		end

	create_json_object_from_hashtable (table: detachable HASH_TABLE [SWAGGER_API_OBJECT, STRING]): detachable JSON_OBJECT
		do
			if attached table as hash_table then
				create result.make
				across
					hash_table as t
				loop
					t.item.process (current)
					result.add_value (t.key, intermediate_result)
				end
			end
		end

	create_json_object (object: detachable SWAGGER_API_OBJECT): detachable JSON_VALUE_OBJECT
		do
			if attached object as o then
				o.process (current)
				result := intermediate_result
			end
		end

feature
	-- access

	swagger_json_object: JSON_OBJECT

	create_json(w_o: SWAGGER_OBJECT)
		do
			w_o.process (current)
		end

feature {SWAGGER_API_OBJECT}
	--visitor

	process_contact_object (w_o: CONTACT_OBJECT)
			-- process an object of type CONTACT_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("name", w_o.name)
			json_object.add_string ("url", w_o.url)
			json_object.add_string ("email", w_o.email)
			intermediate_result := json_object
		end

	process_definitions_object (w_o: DEFINITIONS_OBJECT)
			-- process an object of type DEFINITIONS_OBJECT
		do
			intermediate_result := create_json_object_from_hashtable (w_o.definitions)
		end

	process_example_object (w_o: EXAMPLE_OBJECT)
			-- process an object of type EXAMPLE_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
				-- todo
			intermediate_result := json_object
		end

	process_external_documentation_object (w_o: EXTERNAL_DOCUMENTATION_OBJECT)
			-- process an object of type EXTERNAL_DOCUMENTATION_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("url", w_o.url)
			json_object.add_string ("description", w_o.description)
			intermediate_result := json_object
		end

	process_header_object (w_o: HEADER_OBJECT)
			-- process an object of type HEADER_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("type", w_o.type)
			json_object.add_string ("description", w_o.description)
			json_object.add_string ("format", w_o.format)
			json_object.add_string ("collectionFormat", w_o.collection_format)
			json_object.add_string ("pattern", w_o.pattern)
				--TODO: default_value
			json_object.add_real ("maximum", w_o.maximum, w_o.maximum_is_set)
			json_object.add_real ("maximum", w_o.maximum, w_o.maximum_is_set)
			json_object.add_boolean ("exclusiveMaximum", w_o.exclusive_maximum, w_o.exclusive_maximum_is_set)
			json_object.add_real ("minimum", w_o.minimum, w_o.minimum_is_set)
			json_object.add_boolean ("exclusiveMinimum", w_o.exclusive_minimum, w_o.exclusive_minimum_is_set)
			json_object.add_integer ("maxLength", w_o.max_length, w_o.max_length_is_set)
			json_object.add_integer ("minLength", w_o.min_length, w_o.min_length_is_set)
			json_object.add_integer ("maxItems", w_o.max_items, w_o.max_items_is_set)
			json_object.add_integer ("minItems", w_o.min_items, w_o.min_items_is_set)
			json_object.add_boolean ("uniqueItems", w_o.unique_items, w_o.unique_items_is_set)
			json_object.add_real ("mulitpleOf", w_o.multiple_of, w_o.multiple_of_is_set)
				--TODO: enum
			intermediate_result := json_object
		end

	process_headers_object (w_o: HEADERS_OBJECT)
			-- process an object of type HEADERS_OBJECT
		do
			intermediate_result := create_json_object_from_hashtable (w_o.headers)
		end

	process_info_object (w_o: INFO_OBJECT)
			-- process an object of type INFO_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("version", w_o.version)
			json_object.add_string ("title", w_o.title)
			json_object.add_value ("contact", create_json_object (w_o.contact))
			json_object.add_value ("license", create_json_object (w_o.license))
			intermediate_result := json_object
		end

	process_items_object (w_o: ITEMS_OBJECT)
			-- process an object of type ITEMS_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("type", w_o.type)
			json_object.add_string ("format", w_o.format)
			if attached w_o.items as i then
				i.process (current)
					--json_object.add_value ("items", create_)
			end
			json_object.add_string ("collectionFormat", w_o.collection_format)
			json_object.add_real ("maximum", w_o.maximum, w_o.maximum_is_set)
			json_object.add_boolean ("exclusiveMaximum", w_o.exclusive_maximum, w_o.exclusive_maximum_is_set)
			json_object.add_real ("minimum", w_o.minimum, w_o.minimum_is_set)
			json_object.add_boolean ("exclusiveMinimum", w_o.exclusive_minimum, w_o.exclusive_minimum_is_set)
			json_object.add_integer ("maxLength", w_o.max_length, w_o.max_length_is_set)
			json_object.add_integer ("minLength", w_o.min_length, w_o.min_length_is_set)
			json_object.add_integer ("maxItems", w_o.max_items, w_o.max_items_is_set)
			json_object.add_integer ("minItems", w_o.min_items, w_o.min_items_is_set)
			json_object.add_boolean ("uniqueItems", w_o.unique_items, w_o.unique_items_is_set)
			json_object.add_real ("multipleOf", w_o.multiple_of, w_o.multiple_of_is_set)
				--TODO: default_value
			intermediate_result := json_object
		end

	process_license_object (w_o: LICENSE_OBJECT)
			-- process an object of type LICENSE_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("name", w_o.name)
			json_object.add_string ("url", w_o.url)
			intermediate_result := json_object
		end

	process_operation_object (w_o: OPERATION_OBJECT)
			-- process an object of type OPERATION_OBJECT
		local
			temp_list: LINKED_LIST [SWAGGER_API_OBJECT]
			json_object: JSON_OBJECT
		do
			create json_object.make
			w_o.responses.process (current)
			json_object.add_value ("responses", intermediate_result)
			json_object.add_value ("tags", create_json_string_array (w_o.tags))
			json_object.add_string ("summary", w_o.summary)
			json_object.add_string ("description", w_o.description)
			json_object.add_value ("externalDocs", create_json_object (w_o.external_docs))
			json_object.add_string ("operationId", w_o.operation_id)
			json_object.add_value ("consumes", create_json_string_array (w_o.consumes))
			json_object.add_value ("produces", create_json_string_array (w_o.produces))
			json_object.add_boolean ("deprecated", w_o.deprecated, true)
			create temp_list.make
			if attached w_o.parameters as p then
				temp_list.append (p)
			end
			if attached w_o.references as r then
				temp_list.append (r)
			end
			if temp_list.count > 0 then
				json_object.add_value ("parameters", create_json_object_array (temp_list))
			end
			intermediate_result := json_object
		end

	process_parameter_body_object (w_o: PARAMETER_BODY_OBJECT)
			-- process an object of type PARAMETER_BODY_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("name", w_o.name)
			json_object.add_string ("in", w_o.in);
			json_object.add_boolean ("required", w_o.required, true);
			json_object.add_value ("schema", create_json_object (w_o.schema))
				--todo error handling
			json_object.add_string ("description", w_o.description)
			intermediate_result := json_object
		end

	process_parameter_other_object (w_o: PARAMETER_OTHER_OBJECT)
			-- process an object of type PARAMETER_OTHER_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("name", w_o.name);
			json_object.add_string ("in", w_o.in);
			json_object.add_boolean ("required", w_o.required, true);
			json_object.add_string ("type", w_o.type);
			json_object.add_string ("description", w_o.description)
			json_object.add_string ("format", w_o.format)
			json_object.add_value ("items", create_json_object (w_o.items))
			json_object.add_string ("collectionFormat", w_o.collection_format)
			json_object.add_real ("maximum", w_o.maximum, w_o.maximum_is_set)
			json_object.add_boolean ("exclusiveMaximum", w_o.exclusive_maximum, w_o.exclusive_maximum_is_set)
			json_object.add_real ("minimum", w_o.minimum, w_o.minimum_is_set)
			json_object.add_boolean ("exclusiveMinimum", w_o.exclusive_minimum, w_o.exclusive_minimum_is_set)
			json_object.add_integer ("maxLength", w_o.max_length, w_o.max_length_is_set)
			json_object.add_integer ("minLength", w_o.min_length, w_o.min_length_is_set)
			json_object.add_integer ("maxItems", w_o.max_items, w_o.max_items_is_set)
			json_object.add_integer ("minItems", w_o.min_items, w_o.min_items_is_set)
			json_object.add_boolean ("uniqueItems", w_o.unique_items, w_o.unique_items_is_set)
			json_object.add_real ("multipleOf", w_o.multiple_of, w_o.multiple_of_is_set)
				--TODO: default_value
			intermediate_result := json_object
		end

	process_parameters_definitions_object (w_o: PARAMETERS_DEFINITIONS_OBJECT)
			-- process an object of type PARAMETERS_DEFINITIONS_OBJECT
		do
			intermediate_result := create_json_object_from_hashtable (w_o.parameters)
		end

	process_path_item_object (w_o: PATH_ITEM_OBJECT)
			-- process an object of type PATH_ITEM_OBJECT
		local
			temp_list: LINKED_LIST [SWAGGER_API_OBJECT]
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_value ("get", create_json_object (w_o.get))
			json_object.add_value ("put", create_json_object (w_o.put))
			json_object.add_value ("post", create_json_object (w_o.post))
			json_object.add_value ("delete", create_json_object (w_o.delete))
			json_object.add_value ("options", create_json_object (w_o.options))
			json_object.add_value ("head", create_json_object (w_o.head))
			json_object.add_value ("patch", create_json_object (w_o.patch))
			create temp_list.make
			if attached w_o.parameters as p then
				temp_list.append (p)
			end
			if attached w_o.references as r then
				temp_list.append (r)
			end
			if temp_list.count > 0 then
				json_object.add_value ("parameters", create_json_object_array (temp_list))
			end
			intermediate_result := json_object
		end

	process_paths_object (w_o: PATHS_OBJECT)
			-- process an object of type PATHS_OBJECT
		do
			intermediate_result := create_json_object_from_hashtable (w_o.paths)
		end

	process_reference_object (w_o: REFERENCE_OBJECT)
			-- process an object of type REFERENCE_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("$ref", w_o.ref)
			intermediate_result := json_object
		end

	process_response_object (w_o: RESPONSE_OBJECT)
			-- process an object of type RESPONSE_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("description", w_o.description)
			json_object.add_value ("schema", create_json_object (w_o.schema))
			json_object.add_value ("headers", create_json_object (w_o.headers))
			json_object.add_value ("examples", create_json_object (w_o.examples))
			intermediate_result := json_object
		end

	process_responses_definitions_object (w_o: RESPONSES_DEFINITIONS_OBJECT)
			-- process an object of type RESPONSES_DEFINITIONS_OBJECT
		do
			intermediate_result := create_json_object_from_hashtable (w_o.responses)
		end

	process_responses_object (w_o: RESPONSES_OBJECT)
			-- process an object of type RESPONSES_OBJECT
		do
			intermediate_result := create_json_object_from_hashtable (w_o.responses)
				--TODO references
		end

	process_schema_object (w_o: SCHEMA_OBJECT)
			-- process an object of type SCHEMA_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("type", w_o.type)
			json_object.add_string ("description", w_o.description)
			json_object.add_string ("format", w_o.format)
			json_object.add_string ("pattern", w_o.pattern)
			json_object.add_string ("$ref", w_o.ref)
			json_object.add_real ("multiple_of", w_o.multiple_of, w_o.multiple_of_is_set)
			json_object.add_real ("maximum", w_o.maximum, w_o.maximum_is_set)
			json_object.add_boolean ("exclusiveMaximum", w_o.exclusiveMaximum, w_o.exclusiveMaximum_is_set)
			json_object.add_real ("minimum", w_o.minimum, w_o.minimum_is_set)
			json_object.add_boolean ("exclusiveMinimum", w_o.exclusiveMinimum, w_o.exclusiveMinimum_is_set)
			json_object.add_integer ("maxLength", w_o.maxLength, w_o.maxLength_is_set)
			json_object.add_integer ("minLength", w_o.minLength, w_o.minLength_is_set)
			json_object.add_integer ("maxItems", w_o.maxItems, w_o.maxItems_is_set)
			json_object.add_integer ("minItems", w_o.minItems, w_o.minItems_is_set)
			json_object.add_boolean ("uniqueItems", w_o.uniqueItems, w_o.uniqueItems_is_set)
			json_object.add_integer ("maxProperties", w_o.maxProperties, w_o.maxProperties_is_set)
			json_object.add_integer ("minProperties", w_o.minProperties, w_o.minProperties_is_set)
			json_object.add_boolean ("required", w_o.required, w_o.required_is_set)
				-- TODO enum, default_value
			intermediate_result := json_object
		end

	process_scopes_object (w_o: SCOPES_OBJECT)
			-- process an object of type SCOPES_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			across
				w_o.scopes as o
			loop
				json_object.add_string (o.key, o.item);
			end
			intermediate_result := json_object
		end

	process_security_definitions_object (w_o: SECURITY_DEFINITIONS_OBJECT)
			-- process an object of type SECURITY_DEFINITIONS_OBJECT
		do
			intermediate_result := create_json_object_from_hashtable (w_o.security_schemes)
		end

	process_security_requirement_object (w_o: SECURITY_REQUIREMENT_OBJECT)
			-- process an object of type SECURITY_REQUIREMENT_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
				--todo
			intermediate_result := json_object
		end

	process_security_scheme_object (w_o: SECURITY_SCHEME_OBJECT)
			-- process an object of type SECURITY_SCHEME_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("type", w_o.type);
			json_object.add_string ("name", w_o.name);
			json_object.add_string ("in", w_o.in);
			json_object.add_string ("flow", w_o.flow);
			json_object.add_string ("authorizationUrl", w_o.authorization_url);
			json_object.add_string ("tokenUrl", w_o.token_url);
			json_object.add_value ("scopes", create_json_object (w_o.scopes))
			json_object.add_string ("description", w_o.description)
			intermediate_result := json_object
		end

	process_swagger_object (w_o: SWAGGER_OBJECT)
			-- process an object of type SWAGGER_OBJECT
		do
			create swagger_json_object.make
			swagger_json_object.add_string ("swagger", w_o.swagger)
			w_o.info.process (current)
			swagger_json_object.add_value ("info", intermediate_result)
			w_o.paths.process (current)
			swagger_json_object.add_value ("paths", intermediate_result)
			swagger_json_object.add_string ("host", w_o.host)
			swagger_json_object.add_string ("basePath", w_o.base_path)
			swagger_json_object.add_value ("schemes", create_json_string_array (w_o.schemes))
			swagger_json_object.add_value ("consumes", create_json_string_array (w_o.consumes))
			swagger_json_object.add_value ("produces", create_json_string_array (w_o.produces))
			swagger_json_object.add_value ("definitions", create_json_object (w_o.definitions))
			swagger_json_object.add_value ("parameters", create_json_object (w_o.parameters))
			swagger_json_object.add_value ("responses", create_json_object (w_o.responses))
			swagger_json_object.add_value ("securityDefinitions", create_json_object (w_o.security_definitions))
			swagger_json_object.add_value ("security", create_json_object_array (w_o.security_requirements))
			swagger_json_object.add_value ("tags", create_json_object_array (w_o.tags))
		end

	process_tag_object (w_o: TAG_OBJECT)
			-- process an object of type TAG_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_string ("name", w_o.name)
			json_object.add_string ("description", w_o.description)
			json_object.add_value ("externalDocs", create_json_object (w_o.external_docs))
			intermediate_result := json_object
		end

	process_xml_object (w_o: XML_OBJECT)
			-- process an object of type XML_OBJECT
		local
			json_object: JSON_OBJECT
		do
			create json_object.make
			json_object.add_boolean ("attribute", w_o.is_attribute, true)
			json_object.add_boolean ("wrapped", w_o.wrapped, true)
			json_object.add_string ("name", w_o.name)
			json_object.add_string ("namespace", w_o.namespace)
			json_object.add_string ("prefix", w_o.prefix_string)
			intermediate_result := json_object
		end

end
