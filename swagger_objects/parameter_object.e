note
	description: "Summary description for {PARAMETER_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PARAMETER_OBJECT
inherit
	SWAGGER_API_OBJECT
feature
	name: STRING
		-- the name of the parameter
	in: STRING
		-- the location of the parameter
	description: STRING
		-- a brief description of the parameter
	required: BOOLEAN
		-- determines whether this parameter is mandatory

	set_descrption(a_description: STRING)
		-- sets the description
		do
			description := a_description
		end

	set_required(is_required: BOOLEAN)
		-- sets the required value
		do
			required := is_required
		end
end
