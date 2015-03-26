note
	description: "Generates a JSON file representing a swagger documentation. The documentation is created from annotations within the note section of the Eiffel code"
	author: "Tobias kaiser"
	date: "$Date$"
	revision: "$Revision$"

class
	SWAGGER_DOC_GENERATOR

inherit

	STRING_HANDLER

create
	make

feature {NONE}

	parser: EIFFEL_PARSER
			-- parses Eiffel class files

	factory: AST_FACTORY
			-- ast node factory

	swagger_object_creator: SWAGGER_OBJECT_CREATOR
			-- creates a swagger object from eiffel classes

	annotation_validator: ANNOTATION_VALIDATOR_VISITOR
			-- validates the annotations made within the eiffel code

	json_creator: JSON_GENERATOR
			-- creates a json object structure from a swagger object

	json_writer: JSON_WRITER
			-- writes a json object to a *.json file

feature
	-- creation

	make
			-- initializes a new instance
		do
			create annotation_validator
			create swagger_object_creator.make
			create json_creator
			create json_writer.make
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

feature

	create_documentation (path_to_folder: STRING)
			-- creates documentation from a folder containing *.e files (also searches subfolders)
		require
			path_not_void: path_to_folder /= void
		local
			current_file: KL_BINARY_INPUT_FILE_32
			directory_queue: LINKED_LIST [DIRECTORY]
			classes: LINKED_LIST [CLASS_AS]
		do
			create classes.make
			create directory_queue.make
			directory_queue.extend (create {DIRECTORY}.make_with_path (create {PATH}.make_from_string (path_to_folder)))
			from
				directory_queue.start
			until
				directory_queue.after
			loop
				across
					directory_queue.item.entries as files
				loop
					if attached files.item as f and then attached files.item.extension as e and then files.item.extension.same_string ("e") then
							-- parse the found .e file
						create current_file.make_with_path (directory_queue.item.path.extended_path (f))
						current_file.open_read
						io.putstring ("parsing file " + f.out + "%N")
						if current_file.is_open_read then
							parser.parse (current_file)
						end
						current_file.close
						if parser.error_count = 0 then
								-- when no error occured safe the class node
							classes.extend (parser.root_node)
						else
							io.putstring ("error while parsing " + f.out + ":%N")
							io.put_string (parser.error_code.out)
							io.putstring (parser.error_message + "%N")
						end
						parser.wipe_out
						parser.reset
						initialize
					elseif not files.item.utf_8_name.same_string (".") and not files.item.utf_8_name.same_string ("..") then
							-- store all subfolder for further investigation
						directory_queue.extend (create {DIRECTORY}.make_with_path (directory_queue.item.path.extended_path (files.item)))
					end
				end
				directory_queue.forth
			end
			io.putstring ("validating annotations%N")
			annotation_validator.validate_classes (classes)
				-- validate the annotations of the classes
			if annotation_validator.all_annotations_valid then
				io.putstring ("starting to scan classes for swagger annotations%N")
					-- create the swagger object
				swagger_object_creator.create_swagger_object (classes)
				io.putstring ("createing JSON file structure%N")
					-- create the json object
				json_creator.create_json (swagger_object_creator.swagger_object)
				io.putstring ("creating JSON file%N")
					-- write the json object
				json_writer.create_file ("swagger", json_creator.swagger_json_object)
				io.putstring ("done")
			end
		end

invariant
	parser_not_void: parser /= void
	factory_not_void: factory /= void

end
