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
			create info_visitor
			create paths_visitor.make
		end
feature {NONE}
	info_visitor: INFO_OBJECT_CREATOR
	paths_visitor: PATHS_OBJECT_CREATOR

feature
	swagger_object: SWAGGER_OBJECT

feature {NONE}
	swagger: STRING

	extract_swagger_spec(l_as: INDEX_AS): STRING
		-- extracts the swagger specification
	 	do
	 		if attached {STRING_AS} l_as.index_list.first as s then
					Result := s.value_32.twin
				end
	 	end
feature
	create_swagger_object(classes: LINKED_LIST[CLASS_AS])
		do
			create swagger_object.make
			across classes as c
			loop
				c.item.process (current)
			end
			across classes as c
			loop
				c.item.process (paths_visitor)
			end
			swagger_object.set_swagger (swagger)
			swagger_object.set_info (info_visitor.info)
			swagger_object.set_paths (paths_visitor.paths)
		end

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

	--visitor
	process_index_as(l_as: INDEX_AS)
		local
			annotation: STRING
		do
			annotation := l_as.tag.name_32
			if annotation.same_string("sa_spec") then
				swagger := extract_swagger_spec(l_as)
			elseif annotation.same_string ("sa_info") then
				current_class.process (info_visitor)
			end
		end
end
