note
	description: "Summary description for {SWAGGER_DOC_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SWAGGER_DOC_GENERATOR

inherit

	STRING_HANDLER

create
	make

feature

	parser: EIFFEL_PARSER

	factory: AST_FACTORY

	swagger_object_creator: SWAGGER_OBJECT_CREATOR

	annotation_validator: ANNOTATION_VALIDATOR_VISITOR

	json_creator: JSON_GENERATOR

feature

	make
		do
			create annotation_validator
			create swagger_object_creator.make
			create json_creator.make
			initialize
		end

feature {NONE}

	initialize
			--initialize the documentation generator
		do
			create factory
			create parser.make_with_factory (factory)
			parser.set_il_parser
			parser.set_syntax_version (parser.transitional_syntax)
			parser.set_has_syntax_warning (False)
		end

	read_file (path: PATH): STRING
			-- reads a file into a string, returns the string
		require
			path_not_void: path /= void
		local
			file: KL_BINARY_INPUT_FILE_32
			count, nb: INTEGER

		do
			result := ""
			if attached path as p and then attached p.extension as ext and then ext.is_case_insensitive_equal ("e") then
				create file.make_with_path (p)
				if file.exists then
					count := file.count
					file.open_read
					if file.is_open_read then
						if result.count < count then
							result.resize (count)
						end
						result.set_count (count)
						nb := file.read_to_string (result, 1, count)
						result.set_count (nb)
						file.close
					else
						io.error.put_string ("Couldn't open: " + p.utf_8_name)
						io.error.put_new_line
					end
				else
					io.error.put_string ("Couldn't find: " + p.utf_8_name)
					io.error.put_new_line
				end
			end
		end

feature {NONE}

	swagger_object: SWAGGER_OBJECT

feature

	create_documentation (path_to_folder: STRING)
			-- creates documentation from a *.e file
		require
			path_not_void: path_to_folder /= void
		local
			current_file: KL_BINARY_INPUT_FILE_32
			directory: DIRECTORY
			classes: LINKED_LIST [CLASS_AS]
		do
			create classes.make
			create directory.make_with_path (create {PATH}.make_from_string (path_to_folder))
			across
				directory.entries as files
			loop
				if attached files.item as f and then attached files.item.extension as e and then files.item.extension.same_string ("e") then
					create current_file.make_with_path (directory.path.extended_path (f))
					current_file.open_read
					io.putstring ("parsing file " + f.out + "%N")
					if current_file.is_open_read then
						parser.parse (current_file)
					end
					current_file.close
					if parser.error_count = 0 then
						classes.extend (parser.root_node)
						parser.reset
						initialize
					else
						io.putstring ("error while parsing " + f.out + ":%N")
						io.put_string (parser.error_code.out)
						io.putstring (parser.error_message + "%N")
					end
					parser.wipe_out
				end
			end
			io.putstring ("validating annotations%N")
			annotation_validator.validate_classes (classes)
			if annotation_validator.all_annotations_valid then
				io.putstring ("starting to scan classes for swagger annotations%N")
				swagger_object_creator.create_swagger_object (classes)
				io.putstring ("creating JSON file%N")
				json_creator.process_swagger_object (swagger_object_creator.swagger_object)
				io.putstring ("done")
			end
		end

invariant
	parser_not_void: parser /= void
	factory_not_void: factory /= void

end
