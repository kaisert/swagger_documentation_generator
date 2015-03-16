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
	factory: AST_ROUNDTRIP_FACTORY
	visitor: INDEXING_NOTES_VISITOR

feature
	make
	do
		initialize
	end

feature {NONE}

	initialize
		--initialize the documentation generator
	do
		create factory
		create parser.make_with_factory (factory)
		create visitor
		parser.set_il_parser
		parser.set_syntax_version (parser.transitional_syntax)
	end

	read_file(path: PATH): STRING
	-- reads a file into a string, returns the string
	require
		path_not_void: path /= void
	local
		file: KL_BINARY_INPUT_FILE_32
		count, nb: INTEGER
	do
		result := ""
		if
			attached path as p and then
			attached p.extension as ext and then
			ext.is_case_insensitive_equal("e")
		then
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

	create_documentation_from_file(path: STRING)
		-- creates documentation from a *.e file
	require
		path_not_void: path /= void
	local
		current_file: KL_BINARY_INPUT_FILE_32
	do
		create current_file.make_with_path (create {PATH}.make_from_string (path))
		current_file.open_read
		parser.parse_class_from_file (current_file, Void, Void)
		if parser.error_count = 0 then
			io.putstring ("success")
			visitor.set_match_list (parser.match_list)
			--visitor.process_class_as (parser.root_node)
		else
			io.putstring ("error")
		end
	end

invariant
	parser_not_void: parser /= void
	factory_not_void: factory /= void

end
