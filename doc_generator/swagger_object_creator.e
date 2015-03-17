note
	description: "Summary description for {SWAGGER_OBJECT_CREATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SWAGGER_OBJECT_CREATOR
inherit
	INDEXING_NOTES_VISITOR
create
	make
feature
	make
		--initializes a new instance
		do
		end

feature
	swagger_object: SWAGGER_OBJECT

feature {NONE}
	swagger: STRING
	info: INFO_OBJECT
	paths: PATHS_OBJECT

	extract_swagger_spec(l_as: INDEX_AS): STRING
	 	do
	 		Result := l_as.index_list.first.string_value_32
	 	end
	 extract_info(l_as: INDEX_AS): INFO_OBJECT
	 	local
	 		current_index, title, version: STRING
	 	do
	 		current_index := ""
			across l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as s then
					current_index.copy (s.value_32)
				end
				if current_index.starts_with("title=") then
					current_index.replace_substring_all("title=", "")
					title := current_index.twin
				elseif current_index.starts_with ("version=") then
					current_index.replace_substring_all("version=", "")
					version := current_index.twin
				end
			end
			create Result.make (title, version)
	 	end
feature
	--visitor
	process_index_as(l_as: INDEX_AS)
		do
			if l_as.tag.name_32.same_string("sa_spec") then
				swagger := extract_swagger_spec(l_as)
			elseif l_as.tag.name_32.same_string ("sa_info") then
				info := extract_info(l_as)
				create paths.make
				create swagger_object.make (swagger, info, paths)
			end
		end
end
