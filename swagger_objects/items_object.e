note
	description: "Summary description for {ITEMS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITEMS_OBJECT
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
	enum: LINKED_LIST[ANY]
	multiple_of: REAL

	set_type(a_type: STRING)
		-- sets the type
		do
			type := a_type
		end
	set_format(a_format: STRING)
		--sets the format
		do
			format := a_format
		end

	set_items(a_items: ITEMS_OBJECT)
		-- sets items
		do
			items := a_items
		end

	set_collection_format(a_collection_format: STRING)
		-- sets collection format
		do
			collection_format := a_collection_format
		end

	set_default_value(a_default: ANY)
		do
			default_value := a_default
		end

	set_maximum(a_maximum: REAL)
		do
			maximum := a_maximum
		end
	set_exclusive_maximum(a_exclusive_maximum: BOOLEAN)
		do
			exclusive_maximum := a_exclusive_maximum
		end
	set_minimum(a_minimum: REAL)
		do
			minimum := a_minimum
		end
	set_exclusive_minimum(a_exclusive_minimum: BOOLEAN)
		do
			exclusive_minimum := a_exclusive_minimum
		end
	set_max_length(a_max_length: INTEGER)
		do
			max_length := a_max_length
		end
	set_min_length(a_min_length: INTEGER)
		do
			min_length := a_min_length
		end
	set_pattern(a_pattern: STRING)
		do
			pattern := a_pattern
		end
	set_max_item(a_max_items: INTEGER)
		do
			max_items := a_max_items
		end
	set_min_items(a_min_items: INTEGER)
		do
			min_items := a_min_items
		end
	set_unique_items(a_unique_items: BOOLEAN)
		do
			unique_items := a_unique_items
		end
	set_enum(a_enum: LINKED_LIST[ANY])
		do
			enum := a_enum
		end
	set_multiple_of(a_multiple_of: REAL)
		do
			multiple_of := a_multiple_of
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_items_object(current)
		end

end
