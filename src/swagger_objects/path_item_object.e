note
	description: "Summary description for {PATH_ITEM_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PATH_ITEM_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make
feature
	make
		-- initializes new instance
		do
			initialize
		end


feature
	--ref: STRING
		-- ALLOWS
	path: STRING
		-- path of the operation
	get: OPERATION_OBJECT
		-- a definition of a get operation on this path
	put: OPERATION_OBJECT
		-- a definition of a put operation on this path
	post: OPERATION_OBJECT
		-- a definition of a post operation on this path
	delete: OPERATION_OBJECT
		-- a definition of a delete operation on this path
	options: OPERATION_OBJECT
		-- a definition of a options operation on this path
	head: OPERATION_OBJECT
		-- a definition of a head operation on this path
	patch: OPERATION_OBJECT
		-- a definition of a patch operation on this path
	parameters: LINKED_LIST[PARAMETER_OBJECT]
		-- list of parameters that are applicable for all the operations described under this path
	references: LINKED_LIST[REFERENCE_OBJECT]

	set_get(a_get: OPERATION_OBJECT)
		-- sets the get
		do
			get := a_get
		end

	set_put(a_put: OPERATION_OBJECT)
		-- sets the put
		do
			put := a_put
		end

	set_post(a_post: OPERATION_OBJECT)
		-- sets the post
		do
			post := a_post
		end

	set_delete(a_delete: OPERATION_OBJECT)
		-- sets the get
		do
			delete := a_delete
		end

	set_options(a_options: OPERATION_OBJECT)
		-- sets the options
		do
			options := a_options
		end

	set_head(a_head: OPERATION_OBJECT)
		-- sets the head
		do
			head := a_head
		end

	set_patch(a_patch: OPERATION_OBJECT)
		-- sets the get
		do
			patch := a_patch
		end

	add_parameters(a_parameter: PARAMETER_OBJECT)
		-- adds a parameter
		do
			if parameters = void then
				create parameters.make
			end
			parameters.extend(a_parameter)
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_path_item_object(current)
		end
end
