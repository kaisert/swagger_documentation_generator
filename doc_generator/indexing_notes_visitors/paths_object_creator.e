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

feature
	make
		-- initializes a new instance
		do
			class_indexes_handled := false
		end

feature
	reset
		-- resets the visitor
		do
			class_indexes_handled := false
		end

feature
	-- visitor
	process_class_as(l_as: CLASS_AS)
		do
			current_class := l_as
			l_as.top_indexes.process (current)
		end

	process_feature_as(l_as: FEATURE_AS)
		do
			across l_as.indexes as indexes
			loop
				indexes.item.process(current)
			end
		end

	process_feature_clause_as(l_as: FEATURE_CLAUSE_AS)
		do
			across l_as.features as features
			loop
				features.item.process (current)
			end
		end

	process_indexing_clause_as(l_as: INDEXING_CLAUSE_AS)
		do
			across l_as as indexes
			loop
				indexes.item.process (current)
			end
		end

	process_index_as(l_as: INDEX_AS)
		do

		end

end
