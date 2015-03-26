note
	description: "Base class of a json visitor"
	author: "Tobias Kaiser"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_VISITOR

feature {JSON_VALUE_OBJECT}
	-- visitor

	process_json_array (json: JSON_ARRAY [JSON_VALUE_OBJECT])
		deferred
		end

	process_json_integer (json: JSON_INTEGER)
		deferred
		end

	process_json_object (json: JSON_OBJECT)
		deferred
		end

	process_json_real (json: JSON_REAL)
		deferred
		end

	process_json_string (json: JSON_STRING)
		deferred
		end

	process_json_boolean (json: JSON_BOOLEAN)
		deferred
		end

end
