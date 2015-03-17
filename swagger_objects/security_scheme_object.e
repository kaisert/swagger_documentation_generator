note
	description: "Summary description for {SECURITY_SCHEME_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_SCHEME_OBJECT
inherit
	SWAGGER_API_OBJECT
feature
	make(a_type: STRING;
		a_name: STRING;
		a_in: STRING;
		a_flow: STRING;
		a_authorization_url: STRING;
		a_token_url: STRING;
		a_scopes: SCOPES_OBJECT)
	do
		initialize
		type := a_type
		name := a_name
		in := a_in
		flow := a_flow
		authorization_url := a_authorization_url
		token_url := a_token_url
		scopes := a_scopes
	end

feature
	type: STRING
		-- type of security scheme
	description: STRING
		-- short descritpion
	name: STRING
		-- neame of the header or query parameter to be used
	in: STRING
		-- the location of the API key
	flow: STRING
		-- flow used by the OAuth2 security scheme
	authorization_url: STRING
		--The authorization URL to be used for this flow.
	token_url: STRING
		-- The token URL to be used for this flow.
	scopes: SCOPES_OBJECT
		-- The available scopes for the OAuth2 security scheme.

	set_description(a_description: STRING)
		-- sets the descritption
		do
			description := a_description
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_security_scheme_object(current)
		end
end
