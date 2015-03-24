note
	description: "Summary description for {JSON_OBJECT}."
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

	add_value (key: STRING; value: detachable JSON_VALUE_OBJECT)
		do
			if attached value as v then
				values.extend (v, key)
			end
		end

	add_real (key: STRING; value: REAL; is_set: BOOLEAN)
		do
			if is_set then
				values.extend (create {JSON_REAL}.make (value), key)
			end
		end

	add_integer (key: STRING; value: INTEGER; is_set: BOOLEAN)
		do
			if is_set then
				values.extend (create {JSON_INTEGER}.make (value), key)
			end
		end

	add_string (key: STRING; value: STRING)
		do
			if attached value as v then
				values.extend (create {JSON_STRING}.make (value), key)
			end
		end

	add_boolean (key: STRING; value: BOOLEAN; is_set: BOOLEAN)
		do
			if is_set then
				values.extend (create {JSON_BOOLEAN}.make (value), key)
			end
		end

feature
	-- visit

	process (v: JSON_VISITOR)
		do
			v.process_json_object (current)
		end

end
