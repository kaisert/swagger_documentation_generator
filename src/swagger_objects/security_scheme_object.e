note
	description: "Summary description for {SECURITY_SCHEME_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_SCHEME_OBJECT

inherit

	SWAGGER_API_OBJECT

create
	make

feature

	make
		do
			initialize
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

	set_type (a_type: STRING)
			-- sets the type
		do
			type := a_type
		end

	set_description (a_description: STRING)
			-- sets the description
		do
			description := a_description
		end

	set_name (a_name: STRING)
			-- sets the name
		do
			name := a_name
		end

	set_in (a_in: STRING)
			-- sets the in
		do
			in := a_in
		end

	set_flow (a_flow: STRING)
			-- sets the flow
		do
			flow := a_flow
		end

	set_authorization_url (a_authorization_url: STRING)
			-- sets the authorization_url
		do
			authorization_url := a_authorization_url
		end

	set_token_url (a_token_url: STRING)
			-- sets the token_url
		do
			token_url := a_token_url
		end

	set_scopes (a_scopes: SCOPES_OBJECT)
			-- sets the scopes
		do
			scopes := a_scopes
		end

feature {SWAGGER_VISITOR}
	--visitor

	process (v: SWAGGER_VISITOR)
		do
			v.process_security_scheme_object (current)
		end

end
