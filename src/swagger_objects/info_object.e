note
	description: "Summary description for {INFO_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INFO_OBJECT

inherit

	SWAGGER_API_OBJECT

create
	make

feature

	make
			--initialize an instance of INFO_OBJECT
		do
			initialize
		end

feature

	title: STRING
			-- title of the application

	description: detachable STRING
			-- short description of the application

	terms_of_service: detachable STRING
			-- terms of service of the API

	contact: detachable CONTACT_OBJECT
			-- contact information for the exposed API

	license: detachable LICENSE_OBJECT
			-- license information for the exposed API

	version: STRING
			-- provides the version of the application API

	set_titel (a_title: STRING)
			-- sets the title
		do
			title := a_title
		end

	set_version (a_version: STRING)
			-- sets the verison
		do
			version := a_version
		end

	set_description (a_description: STRING)
			-- sets the description
		do
			description := a_description
		end

	set_terms_of_service (a_terms_of_service: STRING)
			-- sets the terms of service
		do
			terms_of_service := a_terms_of_service
		end

	set_contact (a_contact: CONTACT_OBJECT)
			-- sets the contact
		do
			contact := a_contact
		end

	set_license (a_license: LICENSE_OBJECT)
			-- sets the license
		do
			license := a_license
		end

feature {SWAGGER_VISITOR}
	--visitor

	process (v: SWAGGER_VISITOR)
		do
			v.process_info_object (current)
		end

end
