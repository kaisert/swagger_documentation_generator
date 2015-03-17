note
	description: "Summary description for {INDEXING_NOTES_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INDEXING_NOTES_VISITOR

inherit
	AST_NULL_VISITOR
	undefine
		process_index_as
	redefine
		process_class_as,
		process_feature_as,
		process_feature_clause_as,
		process_indexing_clause_as
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
			if attached l_as.features as features then
				across features as f
				loop
					f.item.process(current)
				end
			end
		end

	process_feature_as(l_as: FEATURE_AS)
		do
			if attached l_as.indexes as i then
				across i as indexes
				loop
					indexes.item.process (current)
				end
			end
		end

	process_feature_clause_as(l_as: FEATURE_CLAUSE_AS)
		do
			if attached l_as.features as f then
				across f as features
				loop
					features.item.process (current)
				end
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
		deferred
		end
end
