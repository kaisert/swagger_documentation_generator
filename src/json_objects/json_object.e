note
	description: "Object representing a JSON object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_OBJECT

inherit

	JSON_VALUE_OBJECT

create
	make

feature
	-- initialize

	make
		do
			create values.make (10)
		end

feature

	values: HASH_TABLE [JSON_VALUE_OBJECT, STRING]
			-- HASH_TABLE storing field/value pairs

	add_value (key: STRING; value: detachable JSON_VALUE_OBJECT)
			-- adds a json object to the values
		do
			if attached value as v then
				values.extend (v, key)
			end
		end

	add_real (key: STRING; value: REAL; is_set: BOOLEAN)
			-- adds a real JSON object
		do
			if is_set then
				values.extend (create {JSON_REAL}.make (value), key)
			end
		end

	add_integer (key: STRING; value: INTEGER; is_set: BOOLEAN)
			-- adds an integer JSON object
		do
			if is_set then
				values.extend (create {JSON_INTEGER}.make (value), key)
			end
		end

	add_string (key: STRING; value: STRING)
			-- adds a string JSON object
		do
			if attached value as v then
				values.extend (create {JSON_STRING}.make (value), key)
			end
		end

	add_boolean (key: STRING; value: BOOLEAN; is_set: BOOLEAN)
			-- adds a boolean JSON object
		do
			if is_set then
				values.extend (create {JSON_BOOLEAN}.make (value), key)
			end
		end

feature {JSON_VISITOR}
	-- visit

	process (v: JSON_VISITOR)
		do
			v.process_json_object (current)
		end

end
