note
	description: "Summary description for {INDEXING_NOTES_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXING_NOTES_VISITOR

inherit
	AST_NULL_VISITOR
	redefine
		process_class_as,
		process_feature_as,
		process_feature_clause_as,
		process_indexing_clause_as,
		process_index_as
	end
feature
	match_list: LEAF_AS_LIST

	set_match_list(a_match_list: LEAF_AS_LIST)
	do
		match_list := a_match_list
	end

feature
	-- visitor implementation

	process_class_as(l_as: CLASS_AS)
	do
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

	end

	process_index_as(l_as: INDEX_AS)
	do

	end
end
