note
	description: "Summary description for {INFO_OBJECT_CREATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INFO_OBJECT_CREATOR
inherit
	INDEXING_NOTES_VISITOR

feature {NONE}
	extract_info(l_as: INDEX_AS): INFO_OBJECT
		-- extracts the info object
		local
	 		current_index: STRING
	 	do
	 		create result.make
	 		current_index := ""
			across l_as.index_list as index_list
			loop
				if attached {STRING_AS} index_list.item as s then
					current_index.copy (s.value_32)
				end
				if current_index.starts_with("title=") then
					current_index.replace_substring_all("title=", "")
					result.set_titel (current_index.twin)
				elseif current_index.starts_with ("version=") then
					current_index.replace_substring_all("version=", "")
					result.set_version (current_index.twin)
				elseif current_index.starts_with("description=") then
					current_index.replace_substring_all("description=", "")
					result.set_description(current_index.twin)
				elseif current_index.starts_with("terms_of_service=") then
					current_index.replace_substring_all("terms_of_service=", "")
					result.set_terms_of_service(current_index.twin)
				end
			end
		end

		extract_contact(l_as: INDEX_AS): CONTACT_OBJECT
			-- extracts contact information
			local
				current_index: STRING
			do
				create result.make
				current_index := ""
				across l_as.index_list as index_list
				loop
					if attached {STRING_AS} index_list.item as s then
						current_index.copy (s.value_32)
					end
					if current_index.starts_with("name=") then
						current_index.replace_substring_all("name=", "")
						result.set_name (current_index.twin)
					elseif current_index.starts_with("url=") then
						current_index.replace_substring_all("url=", "")
						result.set_url (current_index.twin)
					elseif current_index.starts_with("email=") then
						current_index.replace_substring_all("email=", "")
						result.set_email (current_index.twin)
					end
				end
			end

		extract_license(l_as: INDEX_AS): LICENSE_OBJECT
			-- extracts license informaton
			local
				current_index, name, url: STRING
			do
				current_index := ""
				across l_as.index_list as index_list
				loop
					if attached {STRING_AS} index_list.item as s then
						current_index.copy (s.value_32)
					end
					if current_index.starts_with("name=") then
						current_index.replace_substring_all("name=", "")
						name := current_index.twin
					elseif current_index.starts_with("url=") then
						current_index.replace_substring_all("url=", "")
						url := current_index.twin
					end
				end
				create result.make
				result.set_name (name)
				result.set_url (url)
			end
feature
	info: INFO_OBJECT

feature
	--visitor
	process_class_as(l_as: CLASS_AS)
		do
			current_class := l_as
			l_as.top_indexes.process (current)
		end

	process_feature_as(l_as: FEATURE_AS)
		do
		end

	process_feature_clause_as(l_as: FEATURE_CLAUSE_AS)
		do
		end

	process_indexing_clause_as(l_as: INDEXING_CLAUSE_AS)
		do
			across l_as as indexes
			loop
				indexes.item.process (current)
			end
		end

	process_index_as(l_as: INDEX_AS)
		-- extracts the info object
		do
		 	if l_as.tag.name_32.same_string ("sa_info") then
				info := extract_info(l_as)
			elseif l_as.tag.name_32.same_string ("sa_contact") then
				info.set_contact (extract_contact(l_as))
			elseif l_as.tag.name_32.same_string ("sa_license") then
				info.set_license (extract_license(l_as))
			end
		end
end
