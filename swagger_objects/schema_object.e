note
	description: "Summary description for {SCHEMA_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCHEMA_OBJECT
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
	ref: STRING
		-- the reference string
	format: STRING
		-- format (either int32, int 64, float, double, byte, date, date-time)
	title: STRING
		-- title of the schema
	description: STRING
		-- descritpion string
	default_value: ANY
		-- default object
	multiple_of: REAL
	maximum: REAL
	exclusiveMaximum: BOOLEAN
	minimum: REAL
	exclusiveMinimum: BOOLEAN
	maxLength: INTEGER
	minLength: INTEGER
	pattern: STRING
	maxItems: INTEGER
	minItems: INTEGER
	uniqueItems: BOOLEAN
	maxProperties: INTEGER
	minProperties: INTEGER
	required: BOOLEAN
	enum: LINKED_LIST[ANY]
	type: STRING
		-- return type
	discriminator: STRING
		-- adds support for plymorphism. Property name that is used to differentiate
		-- between other schema that inherit this schema
	read_only: BOOLEAN
		-- flag indicating whether the schema is read only
	xml: XML_OBJECT
		-- may be used only on properties schemas
	external_doc: EXTERNAL_DOCUMENTATION_OBJECT
		-- additinal external documentation
	example: ANY
		-- a free-form protperty to include an exapmle of an instace for this schema

	set_ref(a_ref: STRING)
		-- sets the ref
		do
			ref := a_ref
		end
	set_format(a_format: STRING)
		-- sets the format
		do
			format := a_format
		end
	set_title(a_title: STRING)
		-- sets the title
		do
			title := a_title
		end
	set_description(a_description: STRING)
		-- sets the description
		do
			description := a_description
		end
	set_default(a_default: ANY)
		-- sets the default
		do
			default_value := a_default
		end
	set_multiple_of(a_multiple_of: REAL)
		-- sets the multipleOf
		do
			multiple_of := a_multiple_of
		end
	set_maximum(a_maximum: REAL)
		-- sets the maximum
		do
			maximum := a_maximum
		end
	set_exclusiveMaximum(a_exclusiveMaximum: BOOLEAN)
		-- sets the exclusiveMaximum
		do
			exclusiveMaximum := a_exclusiveMaximum
		end
	set_minimum(a_minimum: REAL)
		-- sets the minimum
		do
			minimum := a_minimum
		end
	set_exclusiveMinimum(a_exclusiveMinimum: BOOLEAN)
		-- sets the exclusiveMinimum
		do
			exclusiveMinimum := a_exclusiveMinimum
		end
	set_maxLength(a_maxLength: INTEGER)
		-- sets the maxLength
		do
			maxLength := a_maxLength
		end
	set_minLength(a_minLength: INTEGER)
		-- sets the minLength
		do
			minLength := a_minLength
		end
	set_pattern(a_pattern: STRING)
		-- sets the pattern
		do
			pattern := a_pattern
		end
	set_maxItems(a_maxItems: INTEGER)
		-- sets the maxItems
		do
			maxItems := a_maxItems
		end
	set_minItems(a_minItems: INTEGER)
		-- sets the minItems
		do
			minItems := a_minItems
		end
	set_uniqueItems(a_uniqueItems: BOOLEAN)
		-- sets the uniqueItems
		do
			uniqueItems := a_uniqueItems
		end
	set_maxProperties(a_maxProperties: INTEGER)
		-- sets the maxProperties
		do
			maxProperties := a_maxProperties
		end
	set_minProperties(a_minProperties: INTEGER)
		-- sets the minProperties
		do
			minProperties := a_minProperties
		end
	set_required(a_required: BOOLEAN)
		-- sets the required
		do
			required := a_required
		end
	add_enum(a_enum: LINKED_LIST[ANY])
		-- sets the enum
		do
			if enum = void then
				create enum.make
			end
			enum.extend(a_enum)
		end
	set_type(a_type: STRING)
		-- sets the type
		do
			type := a_type
		end
	set_discriminator(a_discriminator: STRING)
		-- sets the discriminator
		do
			discriminator := a_discriminator
		end
	set_read_only(a_read_only: BOOLEAN)
		-- sets the read_only
		do
			read_only := a_read_only
		end
	set_xml(a_xml: XML_OBJECT)
		-- sets the xml
		do
			xml := a_xml
		end
	set_external_doc(a_external_doc: EXTERNAL_DOCUMENTATION_OBJECT)
		-- sets the external_doc
		do
			external_doc := a_external_doc
		end
	set_example(a_example: ANY)
		-- sets the example
		do
			example := a_example
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_schema_object(current)
		end

end
