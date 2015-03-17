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

feature{NONE}
	json_output_file: PLAIN_TEXT_FILE

	intent: STRING

	add_intent
		-- adds spaces to the intent
		do
			intent.append("  ")
		end

	remove_intent
		-- removes two spaces from intent
		require
			intent.count > 1
		do
			intent.remove_tail (2)
		end
	output(text: STRING)
		require
			json_output_file.is_open_write
		do
			json_output_file.putstring (text)
		end

	i_output(text: STRING)
		-- writes a string into the json file
		do
			output (intent + text)
		end

	output_nl
		--writes a string into the json file and puts a new line
		do
			output("%N")
		end
feature
	make
		--initializes a new instance
		do
			intent := ""
		end
feature
	--visitor
	process_contact_object(w_o: CONTACT_OBJECT)
		-- process an object of type CONTACT_OBJECT
		do
		end

	process_definitions_object(w_o: DEFINITIONS_OBJECT)
		-- process an object of type DEFINITIONS_OBJECT
		do
		end

	process_example_object(w_o: EXAMPLE_OBJECT)
		-- process an object of type EXAMPLE_OBJECT
		do
		end

	process_external_documentation_object(w_o: EXTERNAL_DOCUMENTATION_OBJECT)
		-- process an object of type EXTERNAL_DOCUMENTATION_OBJECT
		do
		end

	process_header_object(w_o: HEADER_OBJECT)
		-- process an object of type HEADER_OBJECT
		do
		end

	process_headers_object(w_o: HEADERS_OBJECT)
		-- process an object of type HEADERS_OBJECT
		do
		end

	process_info_object(w_o: INFO_OBJECT)
		-- process an object of type INFO_OBJECT
		do
			i_output("%"info%": {")
			output_nl
			add_intent
			i_output("%"version%": %"")
			output(w_o.version)
			output("%",")
			output_nl
			i_output("%"title%": %"")
			output(w_o.title)
			output("%"")
			output_nl
			remove_intent
			i_output("},")
			output_nl
		end

	process_items_object(w_o: ITEMS_OBJECT)
		-- process an object of type ITEMS_OBJECT
		do
		end

	process_license_object(w_o: LICENSE_OBJECT)
		-- process an object of type LICENSE_OBJECT
		do
		end

	process_operation_object(w_o: OPERATION_OBJECT)
		-- process an object of type OPERATION_OBJECT
		do
		end

	process_parameter_body_object(w_o: PARAMETER_BODY_OBJECT)
		-- process an object of type PARAMETER_BODY_OBJECT
		do
		end

	process_parameter_other_object(w_o: PARAMETER_OTHER_OBJECT)
		-- process an object of type PARAMETER_OTHER_OBJECT
		do
		end

	process_parameters_definitions_object(w_o: PARAMETERS_DEFINITIONS_OBJECT)
		-- process an object of type PARAMETERS_DEFINITIONS_OBJECT
		do
		end

	process_path_item_object(w_o: PATH_ITEM_OBJECT)
		-- process an object of type PATH_ITEM_OBJECT
		do
		end

	process_paths_object(w_o: PATHS_OBJECT)
		-- process an object of type PATHS_OBJECT
		do
			i_output("%"paths%": {")
			output_nl
			add_intent

			remove_intent
			i_output("}")
			output_nl
		end

	process_reference_object(w_o: REFERENCE_OBJECT)
		-- process an object of type REFERENCE_OBJECT
		do
		end

	process_response_object(w_o: RESPONSE_OBJECT)
		-- process an object of type RESPONSE_OBJECT
		do
		end

	process_responses_definitions_object(w_o: RESPONSES_DEFINITIONS_OBJECT)
		-- process an object of type RESPONSES_DEFINITIONS_OBJECT
		do
		end

	process_responses_object(w_o: RESPONSES_OBJECT)
		-- process an object of type RESPONSES_OBJECT
		do
		end

	process_schema_object(w_o: SCHEMA_OBJECT)
		-- process an object of type SCHEMA_OBJECT
		do
		end

	process_scopes_object(w_o: SCOPES_OBJECT)
		-- process an object of type SCOPES_OBJECT
		do
		end

	process_security_definitions_object(w_o: SECURITY_DEFINITIONS_OBJECT)
		-- process an object of type SECURITY_DEFINITIONS_OBJECT
		do
		end

	process_security_requirement_object(w_o: SECURITY_REQUIREMENT_OBJECT)
		-- process an object of type SECURITY_REQUIREMENT_OBJECT
		do
		end

	process_security_scheme_object(w_o: SECURITY_SCHEME_OBJECT)
		-- process an object of type SECURITY_SCHEME_OBJECT
		do
		end

	process_swagger_object(w_o: SWAGGER_OBJECT)
		-- process an object of type SWAGGER_OBJECT
		do
			create json_output_file.make_open_write("swagger.json")
			i_output("{")
			output_nl
			add_intent
			i_output("%"swagger%": %"")
			output(w_o.swagger)
			output("%",")
			output_nl
			w_o.info.process (current)
			w_o.paths.process (current)
			remove_intent
			output("}")
		end

	process_tag_object(w_o: TAG_OBJECT)
		-- process an object of type TAG_OBJECT
		do
		end

	process_xml_object(w_o: XML_OBJECT)
		-- process an object of type XML_OBJECT
		do
		end

end
