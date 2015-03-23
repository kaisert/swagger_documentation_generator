note
	description: "Summary description for {HEADER_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_OBJECT

inherit

	SWAGGER_API_OBJECT

create
	make

feature

	make
			-- initializes a new instance
		do
			initialize
		end

feature

	description: STRING
			-- a short description of the header

	type: STRING
			-- type of the parameter

	format: STRING
			-- extending format for the type

	items: ITEMS_OBJECT
			-- describes type of items in array

	collection_format: STRING
			-- determines the format of the array if type array is used

	default_value: ANY
			-- sets default value to parameter

	maximum: REAL

	exclusive_maximum: BOOLEAN

	minimum: REAL

	exclusive_minimum: BOOLEAN

	max_length: INTEGER

	min_length: INTEGER

	pattern: STRING

	max_items: INTEGER

	min_items: INTEGER

	unique_items: BOOLEAN

	enum: LINKED_LIST [ANY]

	multiple_of: REAL


	maximum_is_set: BOOLEAN
			-- flag, indicating if maximum was set or not

	exclusive_maximum_is_set: BOOLEAN
			-- flag, indicating if exclusive_maximum was set or not

	minimum_is_set: BOOLEAN
			-- flag, indicating if minimum was set or not

	exclusive_minimum_is_set: BOOLEAN
			-- flag, indicating if exclusive_minimum was set or not

	max_length_is_set: BOOLEAN
			-- flag, indicating if max_length was set or not

	min_length_is_set: BOOLEAN
			-- flag, indicating if min_length was set or not

	pattern_is_set: BOOLEAN
			-- flag, indicating if pattern was set or not

	max_items_is_set: BOOLEAN
			-- flag, indicating if max_items was set or not

	min_items_is_set: BOOLEAN
			-- flag, indicating if min_items was set or not

	unique_items_is_set: BOOLEAN
			-- flag, indicating if unique_items was set or not

	multiple_of_is_set: BOOLEAN
			-- flag, indicating if multiple_of was set or not
			
	set_description (a_description: STRING)
			-- sets the description
		do
			description := a_description
		end

	set_type (a_type: STRING)
			-- sets the type
		do
			type := a_type
		end

	set_format (a_format: STRING)
			--sets the format
		do
			format := a_format
		end

	set_items (a_items: ITEMS_OBJECT)
			-- sets items
		do
			items := a_items
		end

	set_collection_format (a_collection_format: STRING)
			-- sets collection format
		do
			collection_format := a_collection_format
		end

	set_default_value (a_default: ANY)
		do
			default_value := a_default
		end

	set_maximum (a_maximum: REAL)
		do
			maximum := a_maximum
			maximum_is_set := true
		end

	set_exclusive_maximum (a_exclusive_maximum: BOOLEAN)
		do
			exclusive_maximum := a_exclusive_maximum
			exclusive_maximum_is_set := true
		end

	set_minimum (a_minimum: REAL)
		do
			minimum := a_minimum
			minimum_is_set := true
		end

	set_exclusive_minimum (a_exclusive_minimum: BOOLEAN)
		do
			exclusive_minimum := a_exclusive_minimum
			exclusive_minimum_is_set := true
		end

	set_max_length (a_max_length: INTEGER)
		do
			max_length := a_max_length
			max_length_is_set := true
		end

	set_min_length (a_min_length: INTEGER)
		do
			min_length := a_min_length
			min_length_is_set := true
		end

	set_pattern (a_pattern: STRING)
		do
			pattern := a_pattern
		end

	set_max_items (a_max_items: INTEGER)
		do
			max_items := a_max_items
			max_items_is_set := true
		end

	set_min_items (a_min_items: INTEGER)
		do
			min_items := a_min_items
			min_items_is_set := true
		end

	set_unique_items (a_unique_items: BOOLEAN)
		do
			unique_items := a_unique_items
			unique_items_is_set := true
		end

	set_enum (a_enum: LINKED_LIST [ANY])
		do
			enum := a_enum
		end

	set_multiple_of (a_multiple_of: REAL)
		do
			multiple_of := a_multiple_of
			multiple_of_is_set := true
		end

feature --visitor

	process (v: SWAGGER_VISITOR)
		do
			v.process_header_object (current)
		end

end
