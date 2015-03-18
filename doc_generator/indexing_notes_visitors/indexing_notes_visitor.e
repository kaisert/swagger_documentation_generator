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
		process_index_as,
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
	process_classes(classes: LINKED_LIST[CLASS_AS])
	do
		across classes as c
		loop
			c.item.process (current)
		end
	end

feature {INDEXING_NOTES_VISITOR}
	current_class: CLASS_AS

feature
	-- visitor implementation

	process_class_as(l_as: CLASS_AS)
		deferred
		end

	process_feature_as(l_as: FEATURE_AS)
		deferred
		end

	process_feature_clause_as(l_as: FEATURE_CLAUSE_AS)
		deferred
		end

	process_indexing_clause_as(l_as: INDEXING_CLAUSE_AS)
		deferred
		end

	process_index_as(l_as: INDEX_AS)
		deferred
		end
end
