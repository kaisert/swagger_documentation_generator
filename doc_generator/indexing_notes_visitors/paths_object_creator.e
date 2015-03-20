note
	description: "Summary description for {PATHS_OBJECT_CREATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PATHS_OBJECT_CREATOR

inherit

	INDEXING_NOTES_VISITOR

create
	make

feature {NONE}

	class_indexes_handled: BOOLEAN

	current_base_path: STRING

	schemes: HASH_TABLE [SCHEMA_OBJECT, STRING]

	current_parameter: LINKED_LIST [PARAMETER_OBJECT]

	current_responses: RESPONSES_OBJECT

	current_refs: LINKED_LIST [REFERENCE_OBJECT]

	current_operation: OPERATION_OBJECT

	current_tags: LINKED_LIST [STRING]

	current_consumes: LINKED_LIST [STRING]

	current_produces: LINKED_LIST [STRING]

	current_schemes: LINKED_LIST [STRING]

feature

	make
			-- initializes a new instance
		do
			class_indexes_handled := false
			create paths.make
			create current_parameter.make
			create current_headers.make
			create schemes.make (10)
		end

feature

	paths: PATHS_OBJECT

feature {NONE}

	extract_base_path (l_as: INDEX_AS)
		do
			if attached {STRING_AS} l_as.index_list.first as p then
				current_base_path := p.value_32.twin
			end
		end

	extract_operation (l_as: INDEX_AS)
		local
			current_index: STRING
			path: STRING
		do
			path := ""
			create current_operation.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_index := index.value_32.twin
					if current_index.starts_with ("operation=") then
						current_index.replace_substring_all ("operation=", "")
						current_operation.set_operation (current_index)
					elseif current_index.starts_with ("summary=") then
						current_index.replace_substring_all ("summary=", "")
						current_operation.set_summary (current_index)
					elseif current_index.starts_with ("description=") then
						current_index.replace_substring_all ("description=", "")
						current_operation.set_description (current_index)
					elseif current_index.starts_with ("operation_id=") then
						current_index.replace_substring_all ("operation_id=", "")
						current_operation.set_operation_id (current_index)
					elseif current_index.starts_with ("deprecated=") then
						current_index.replace_substring_all ("deprecated=", "")
						current_operation.set_deprecated (current_index.to_boolean)
					elseif current_index.starts_with ("path=") then
						current_index.replace_substring_all ("path=", "")
						path := current_index
					end
				end
			end
			path := current_base_path + path
			if not paths.paths.has (path) then
				paths.paths.extend (create {PATH_ITEM_OBJECT}.make, path)
			end
			if current_operation.operation.same_string ("get") then
				paths.paths.at (path).set_get (current_operation)
			elseif current_operation.operation.same_string ("put") then
				paths.paths.at (path).set_put (current_operation)
			elseif current_operation.operation.same_string ("post") then
				paths.paths.at (path).set_post (current_operation)
			elseif current_operation.operation.same_string ("delete") then
				paths.paths.at (path).set_delete (current_operation)
			elseif current_operation.operation.same_string ("options") then
				paths.paths.at (path).set_options (current_operation)
			elseif current_operation.operation.same_string ("head") then
				paths.paths.at (path).set_head (current_operation)
			elseif current_operation.operation.same_string ("patch") then
				paths.paths.at (path).set_patch (current_operation)
			end
		end

	extract_tags (l_as: INDEX_AS)
		do
			create current_tags.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_tags.extend (index.value_32.twin)
				end
			end
		end

	extract_consumes (l_as: INDEX_AS)
		do
			create current_consumes.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_consumes.extend (index.value_32.twin)
				end
			end
		end

	extract_produces (l_as: INDEX_AS)
		do
			create current_produces.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_produces.extend (index.value_32.twin)
				end
			end
		end

	extract_schemes (l_as: INDEX_AS)
		do
			create current_schemes.make
			across
				l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as index then
					current_schemes.extend (index.value_32.twin)
				end
			end
		end

feature
	-- visitor

	process_class_as (l_as: CLASS_AS)
		do
			current_class := l_as
			current_base_path := ""
			if attached l_as.top_indexes as indexes then
				indexes.process (current)
			end
			class_indexes_handled := true
			if attached l_as.features as f then
				across
					f as features
				loop
					features.item.process (current)
				end
			end
		end

	process_feature_as (l_as: FEATURE_AS)
		do
			if attached l_as.indexes as indexes then
				current_tags := void
				current_consumes := void
				current_produces := void
				current_schemes := void
				create known_schemes.make (10)
				schemes.wipe_out
				indexes.process (current)
				current_operation.set_tags (current_tags)
				current_operation.set_consumes (current_consumes)
				current_operation.set_produces (current_produces)
				current_operation.set_schemes (current_schemes)
			end
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		do
			if attached l_as.features then
				across
					l_as.features as features
				loop
					features.item.process (current)
				end
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		do
			if class_indexes_handled then
				create current_responses.make
			end
			across
				l_as as indexes
			loop
				indexes.item.process (current)
			end
			if class_indexes_handled then
				current_operation.set_responses (current_responses)
			end
		end

	process_index_as (l_as: INDEX_AS)
		local
			scheme: TUPLE[s: STRING; so: SCHEMA_OBJECT]
			parameter: TUPLE[s: STRING; p: PARAMETER_OBJECT]
			response: TUPLE[s: STRING; r: RESPONSE_OBJECT]
			header: TUPLE[s: STRING; h: HEADER_OBJECT]
			tag: STRING
		do
			tag := l_as.tag.string_value_32
			if class_indexes_handled then
				if tag.same_string ("sa_schema") then
					scheme := extract_schema (l_as)
					schemes.extend (scheme.so, scheme.s)
				elseif tag.same_string ("sa_parameter") then
					if not attached current_operation.parameters then
						-- TODO
					end
					parameter := extract_parameter (l_as)
					--TODO
				elseif tag.same_string ("sa_response") then
					response:=extract_response (l_as)
					current_responses.responses.extend (response.r, response.s)
				elseif tag.same_string ("sa_header") then
					header := extract_header (l_as)
					known_headers.extend (header.h, header.s)
				elseif tag.same_string ("sa_operation") then
					extract_operation (l_as)
				elseif tag.same_string ("sa_operation_tags") then
					extract_tags (l_as)
				elseif tag.same_string ("sa_operation_consumes") then
					extract_consumes (l_as)
				elseif tag.same_string ("sa_operation_produces") then
					extract_produces (l_as)
				elseif tag.same_string ("sa_operation_schemes") then
					extract_schemes (l_as)
				end
					--TODO: externalDocs
					-- 		security
			else
				if tag.same_string ("sa_path") then
					extract_base_path (l_as)
				end
			end
		end

end
