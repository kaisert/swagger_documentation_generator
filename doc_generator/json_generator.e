note
	description: "Summary description for {JSON_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_GENERATOR

inherit

	SWAGGER_VISITOR

create
	make

feature {NONE}

	json_output_file: PLAIN_TEXT_FILE

	intent: STRING

	add_intent
			-- adds spaces to the intent
		do
			intent.append ("  ")
		end

	remove_intent
			-- removes two spaces from intent
		require
			intent.count > 1
		do
			intent.remove_tail (2)
		end

	output (text: STRING)
		require
			json_output_file.is_open_write
			text /= void
		local
			output_text: STRING
		do
			output_text := text.twin
			output_text.replace_substring_all ("/", "\/")
			json_output_file.putstring (output_text)
		end

	i_output (text: STRING)
			-- writes a string into the json file
		do
			output (intent + text)
		end

	output_nl
			--writes a string into the json file and puts a new line
		do
			output ("%N")
		end

	output_para (para, value: STRING)
			-- writes a string of the form
			-- "para": "value"
		do
			i_output ("%"" + para + "%": %"" + value + "%"")
		end

	output_para_bool(para: STRING; value: BOOLEAN)
		do
			i_output ("%"" + para + "%": " + value.out)
		end

	output_para_num (para, value: STRING)
			--writes a string of the form
			-- "para" value
		do
			i_output ("%"" + para + "%": " + value)
		end

	output_list (para: STRING; array: LINKED_LIST [STRING])
		local
			array_string: STRING
		do
			array_string := ""
			i_output ("%"" + para + "%": [")
			output_nl
			add_intent
			across
				array as a
			loop
				array_string := array_string + "%"" + a.item + "%", "
			end
			array_string.remove_tail (2)
			i_output (array_string)
			remove_intent
			output_nl
			i_output ("]")
		end

	output_hashtable_objects (objects: HASH_TABLE [SWAGGER_API_OBJECT, STRING])
		do
			output_nl
			across
				objects as o
			loop
				i_output ("%"");
				output (o.key);
				output ("%": {")
				output_nl
				add_intent
				o.item.process (current)
				output_nl
				remove_intent
				i_output ("},")
			end
		end

	output_list_cond (para: STRING; list: detachable LINKED_LIST [STRING])
		do
			if attached list as l then
				output (",");
				output_nl
				output_list (para, l)
			end
		end

	output_para_cond (para: STRING; value: detachable STRING)
		do
			if attached value as v then
				output (",");
				output_nl
				output_para (para, v)
			end
		end

	output_object (para: STRING; object: SWAGGER_API_OBJECT)
		do
			i_output ("%"" + para + "%": {")
			output_nl
			add_intent
			object.process (current)
			remove_intent
			output_nl
			i_output ("}")
		end

	output_object_cond (para: STRING; object: detachable SWAGGER_API_OBJECT)
		do
			if attached object as o then
				output_nl
				output_object (para, o)
				output (",");
			end
		end

	output_list_objects_cond (para: STRING; objects: detachable LINKED_LIST [SWAGGER_API_OBJECT])
		do
			if attached objects as o then
				i_output ("%"" + para + "%": [")
				output_nl
				add_intent
				across
					o as object
				loop
					i_output ("{")
					add_intent
					output_nl
					object.item.process (current)
					output_nl
					remove_intent
					i_output ("},")
					output_nl
				end
				remove_intent
				i_output ("}")
			end
		end

feature

	make
			--initializes a new instance
		do
			intent := ""
		end

feature
	--visitor

	process_contact_object (w_o: CONTACT_OBJECT)
			-- process an object of type CONTACT_OBJECT
		local
			comma_required: BOOLEAN
		do
			comma_required := false
			if attached w_o.name as n then
				output_para ("name", n)
				comma_required := true
			end
			if attached w_o.url as u then
				if comma_required then
					output (",")
				end
				output_nl
				output_para ("url", u)
				comma_required := true
			end
			if attached w_o.email as e then
				if comma_required then
					output (",")
				end
				output_nl
				output_para ("email", e)
			end
		end

	process_definitions_object (w_o: DEFINITIONS_OBJECT)
			-- process an object of type DEFINITIONS_OBJECT
		do
			output_nl
			output_hashtable_objects (w_o.definitions)
		end

	process_example_object (w_o: EXAMPLE_OBJECT)
			-- process an object of type EXAMPLE_OBJECT
		do
		end

	process_external_documentation_object (w_o: EXTERNAL_DOCUMENTATION_OBJECT)
			-- process an object of type EXTERNAL_DOCUMENTATION_OBJECT
		do
			output_nl
			output_para ("url", w_o.url)
			output_para_cond("description", w_o.description)
		end

	process_header_object (w_o: HEADER_OBJECT)
			-- process an object of type HEADER_OBJECT
		do
			output_nl
			output_para ("type", w_o.type)
			output_para_cond ("description", w_o.description)
			output_para_cond ("format", w_o.format)
			output_para_cond ("collectionFormat", w_o.collection_format)
			output_para_cond ("pattern", w_o.pattern)

				--			if attached w_o.maximum as maximum then
				--				output(","); output_nl;
				--				output_parameter_numerical ("maximum", maximum.out)
				--			end
				--			if attached w_o.exclusive_maximum as exclusive_maximum then
				--				output(","); output_nl;
				--				output_parameter_numerical ("exclusiveMaximum", exclusive_maximum.out)
				--			end
				--			if attached w_o.minimum as minimum then
				--				output(","); output_nl;
				--				output_parameter_numerical ("minimum", minimum.out)
				--			end
				--			if attached w_o.exclusive_minimum as exclusive_minimum then
				--				output(","); output_nl;
				--				output_parameter_numerical ("exclusiveMinimum", exclusive_minimum.out)
				--			end
				--			if attached w_o.max_length as max_length then
				--				output(","); output_nl;
				--				output_parameter_numerical ("maxLength", max_length.out)
				--			end
				--			if attached w_o.min_length as min_length then
				--				output(","); output_nl;
				--				output_parameter_numerical ("minLength", min_length.out)
				--			end
				--			if attached w_o.max_items as max_items then
				--				output(","); output_nl;
				--				output_parameter_numerical ("maxItems", max_items.out)
				--			end
				--			if attached w_o.min_items as min_items then
				--				output(","); output_nl;
				--				output_parameter_numerical ("minItems", min_items.out)
				--			end
				--			if attached w_o.unique_items as unique_items then
				--				output(","); output_nl;
				--				output_parameter_numerical ("uniqueItems", unique_items.out)
				--			end
				--			if attached w_o.multiple_of as multiple_of then
				--				output(","); output_nl;
				--				output_parameter_numerical ("multipleOf", multiple_of.out)
				--			end
				--TODO: enum
				-- numericals
		end

	process_headers_object (w_o: HEADERS_OBJECT)
			-- process an object of type HEADERS_OBJECT
		do
			output_hashtable_objects (w_o.headers)
		end

	process_info_object (w_o: INFO_OBJECT)
			-- process an object of type INFO_OBJECT
		do
			output_para ("version", w_o.version)
			output (",")
			output_nl
			output_para ("title", w_o.title)
			output (",")
			output_object_cond ("contact", w_o.contact)
			output_object_cond ("license", w_o.license)
		end

	process_items_object (w_o: ITEMS_OBJECT)
			-- process an object of type ITEMS_OBJECT
		do
			output_para("type", w_o.type)
			output_nl
			output_para ("format", w_o.format)
			output_nl
			output_object_cond ("Items", w_o.items)
			output_nl
			output_para_cond ("collectionFormat", w_o.collection_format)
			--TODO: rest
		end

	process_license_object (w_o: LICENSE_OBJECT)
			-- process an object of type LICENSE_OBJECT
		local
			comma_required: BOOLEAN
		do
			if attached w_o.name as n then
				output_para ("name", n)
				comma_required := true
			end
			if attached w_o.url as u then
				if comma_required then
					output (",")
				end
				output_nl
				output_para ("url", u)
			end
		end

	process_operation_object (w_o: OPERATION_OBJECT)
			-- process an object of type OPERATION_OBJECT
		do
			i_output ("%"responses%": {")
			add_intent
			output_nl
			w_o.responses.process (current)
			remove_intent
			output_nl
			i_output ("}")
			output_nl
			output_list_cond ("tags", w_o.tags)
			output_para_cond ("summary", w_o.summary)
			output_para_cond ("description", w_o.description)
			output_object_cond ("externalDocs", w_o.external_docs)
			output_para_cond ("operationId", w_o.operation_id)
			output_list_cond ("consumes", w_o.consumes)
			output_list_cond ("produces", w_o.produces)
		end

	process_parameter_body_object (w_o: PARAMETER_BODY_OBJECT)
			-- process an object of type PARAMETER_BODY_OBJECT
		do
			output_para("name", w_o.name); output(","); output_nl
			output_para("in", w_o.in); output(","); output_nl
			output_para_bool("required", w_o.required); output(","); output_nl
			output_object ("schema", w_o.schema); output(","); output_nl
			output_para_cond("description", w_o.description)
		end

	process_parameter_other_object (w_o: PARAMETER_OTHER_OBJECT)
			-- process an object of type PARAMETER_OTHER_OBJECT
		do
			output_para("name", w_o.name); output(","); output_nl
			output_para("in", w_o.in); output(","); output_nl
			output_para_bool("required", w_o.required); output(","); output_nl
			output_para("type", w_o.type); output(","); output_nl
			output_para_cond("description", w_o.description)
			output_para_cond("format", w_o.format)
			output_object_cond ("items", w_o.items)
			output_para_cond("collectionFormat", w_o.collection_format)
			--TODO: rest
		end

	process_parameters_definitions_object (w_o: PARAMETERS_DEFINITIONS_OBJECT)
			-- process an object of type PARAMETERS_DEFINITIONS_OBJECT
		do
			output_hashtable_objects (w_o.parameters)
		end

	process_path_item_object (w_o: PATH_ITEM_OBJECT)
			-- process an object of type PATH_ITEM_OBJECT
		do
			output_object_cond ("get", w_o.get)
			output_object_cond ("put", w_o.put)
			output_object_cond ("post", w_o.post)
			output_object_cond ("delete", w_o.delete)
			output_object_cond ("options", w_o.options)
			output_object_cond ("head", w_o.head)
			output_object_cond ("patch", w_o.patch)
			output_list_objects_cond ("parameters", w_o.parameters)
		end

	process_paths_object (w_o: PATHS_OBJECT)
			-- process an object of type PATHS_OBJECT
		do
			output_hashtable_objects (w_o.paths)
				-- TODO: parameters
		end

	process_reference_object (w_o: REFERENCE_OBJECT)
			-- process an object of type REFERENCE_OBJECT
		do
			output_para("$ref", w_o.ref)
		end

	process_response_object (w_o: RESPONSE_OBJECT)
			-- process an object of type RESPONSE_OBJECT
		do
			output_para ("description", w_o.description); output(",")
			output_object_cond ("schema", w_o.schema)
			output_object_cond ("headers", w_o.headers)
			output_object_cond ("examples", w_o.examples)
		end

	process_responses_definitions_object (w_o: RESPONSES_DEFINITIONS_OBJECT)
			-- process an object of type RESPONSES_DEFINITIONS_OBJECT
		do
			output_hashtable_objects (w_o.responses)
		end

	process_responses_object (w_o: RESPONSES_OBJECT)
			-- process an object of type RESPONSES_OBJECT
		do
			--output_nl
			output_hashtable_objects (w_o.responses)
		end

	process_schema_object (w_o: SCHEMA_OBJECT)
			-- process an object of type SCHEMA_OBJECT
		local
			comma_required: BOOLEAN
		do
			comma_required := false
			if attached w_o.type as t then
				output_para ("type", t)
				comma_required := true
			elseif attached w_o.description as d then
				if comma_required then
					output_nl; output (",")
				end
				output_para ("description", d)
				comma_required := true
			elseif attached w_o.format as f then
				if comma_required then
					output_nl; output (",")
				end
				output_para ("format", f)
				comma_required := true
			elseif attached w_o.pattern as p then
				if comma_required then
					output_nl; output (",")
				end
				output_para ("pattern", p)
				comma_required := true
			elseif attached w_o.ref as r then
				if comma_required then
					output_nl; output (",")
				end
				output_para ("$ref", r)
				comma_required := true
			end
			-- TODO
		end

	process_scopes_object (w_o: SCOPES_OBJECT)
			-- process an object of type SCOPES_OBJECT
		do
			output_nl
			across
				w_o.scopes as o
			loop
				output_para (o.key, o.item); output(","); output_nl
			end
		end

	process_security_definitions_object (w_o: SECURITY_DEFINITIONS_OBJECT)
			-- process an object of type SECURITY_DEFINITIONS_OBJECT
		do
			output_hashtable_objects (w_o.security_schemes)
		end

	process_security_requirement_object (w_o: SECURITY_REQUIREMENT_OBJECT)
			-- process an object of type SECURITY_REQUIREMENT_OBJECT
		do
			--TODO
		end

	process_security_scheme_object (w_o: SECURITY_SCHEME_OBJECT)
			-- process an object of type SECURITY_SCHEME_OBJECT
		do
			output_para ("type", w_o.type); output(","); output_nl
			output_para ("name", w_o.name); output(","); output_nl
			output_para ("in", w_o.in); output(","); output_nl
			output_para ("flow", w_o.flow); output(","); output_nl
			output_para ("authorizationUrl", w_o.authorization_url); output(","); output_nl
			output_para ("tokenUrl", w_o.token_url); output(","); output_nl
			output_object_cond ("scopes", w_o.scopes)
			output_para_cond ("description", w_o.description)
		end

	process_swagger_object (w_o: SWAGGER_OBJECT)
			-- process an object of type SWAGGER_OBJECT
		do
			create json_output_file.make_open_write ("swagger.json")
			i_output ("{")
			output_nl
			add_intent
			output_para ("swagger", w_o.swagger)
			output (","); output_nl
			output_object ("info", w_o.info)
			output (","); output_nl
			output_object ("paths", w_o.paths)
			output_para_cond ("host", w_o.host)
			output_para_cond ("basePath", w_o.base_path)
			output_list_cond ("schemes", w_o.schemes)
			output_list_cond ("consumes", w_o.consumes)
			output_list_cond ("produces", w_o.produces)
			output_object_cond ("definitions", w_o.definitions)
			output_object_cond ("parameters", w_o.parameters)
			output_object_cond ("responses", w_o.responses)
			output_object_cond ("securityDefinitions", w_o.security_definitions)
			output_list_objects_cond ("security", w_o.security)
			output_list_objects_cond ("tags", w_o.tags)
			remove_intent
			output_nl
			output ("}")
			output_nl
		end

	process_tag_object (w_o: TAG_OBJECT)
			-- process an object of type TAG_OBJECT
		do
			output_para ("name", w_o.name)
			output_para_cond ("description", w_o.description)
			output_object_cond ("externalDocs", w_o.external_docs)
		end

	process_xml_object (w_o: XML_OBJECT)
			-- process an object of type XML_OBJECT
		local
			comma_required: BOOLEAN
		do
			output_para_bool ("attribute", w_o.is_attribute)
			output_para_bool ("wrapped", w_o.wrapped)
			output_para_cond ("name", w_o.name)
			output_para_cond ("namespace", w_o.namespace)
			output_para_cond ("prefix", w_o.prefix_string)
		end

end
