note
	description: "Summary description for {CONTACT_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT_OBJECT
inherit
	SWAGGER_API_OBJECT
create
	make

feature
	make
		-- initializes the contact object
		do
			initialize
		end

feature
	name: STRING
		-- the identifying name of the contact person/organization
	url: STRING
		-- the url pointing to the contact information
	email: STRING
		-- email address of the contat person/oranization

	set_name(a_name: STRING)
		-- set the name
		do
			name := a_name
		end

	set_url(a_url: STRING)
		-- sets the url
		do
			url := a_url
		end

	set_email(a_email: STRING)
		-- sets the email
		do
			email := a_email
		end

feature --visitor
	process(v: SWAGGER_VISITOR)
		do
			v.process_contact_object(current)
		end

end
