note
	description: "Writes a JSON object into a *.json file"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_WRITER

inherit

	JSON_VISITOR

create
	make

feature {NONE}

	json_output_file: PLAIN_TEXT_FILE
			-- the output json file

	indent: STRING
			-- current indentation while file write

feature {NONE}
	-- helper features

	output (text: STRING)
			-- outputs text to the json file
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
			-- writes a string into the json file with indentation
		do
			output (indent + text)
		end

	output_nl
			--writes a string into the json file and puts a new line
		do
			output ("%N")
		end

feature
	--initialization

	make
		do
			indent := ""
		end

	add_indent
			-- adds indentation
		do
			indent := indent + "  "
		end

	remove_indent
			-- removes indentation
		do
			indent.remove_tail (2)
		end

feature
	--access

	create_file (file_name: STRING; json: JSON_OBJECT)
			-- creates a *.json file from a json object
		do
			create json_output_file.make_open_write (file_name + ".json")
			json.process (current)
			json_output_file.close
		end

feature {JSON_VALUE_OBJECT}
	--visitor

	process_json_array (json: JSON_ARRAY [JSON_VALUE_OBJECT])
		do
			output ("[");
			output_nl
			add_indent
			across
				json.value as values
			loop
				values.item.process (current)
				if not values.is_last then
					output (",")
				end
				output_nl
			end
			remove_indent
			i_output ("]")
		end

	process_json_integer (json: JSON_INTEGER)
		do
			output (json.value.out)
		end

	process_json_object (json: JSON_OBJECT)
		do
			output ("{");
			output_nl
			add_indent
			across
				json.values as values
			loop
				i_output ("%"" + values.key + "%":")
				values.item.process (current)
				if not values.is_last then
					output (",")
				end
				output_nl
			end
			remove_indent
			i_output ("}")
		end

	process_json_real (json: JSON_REAL)
		do
			output (json.value.out)
		end

	process_json_string (json: JSON_STRING)
		do
			output ("%"" + json.value + "%"")
		end

	process_json_boolean (json: JSON_BOOLEAN)
		local
			temp: STRING
		do
			temp := json.value.out
			temp.to_lower
			output (temp)
		end

end
