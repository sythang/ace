module API
	module V1
		class Base < Grape::API
			prefix 'api'
    	format :json
			version 'v1', using: :path


			mount API::V1::Users
			mount API::V1::Tests
			
			add_swagger_documentation \
				info: {
			    title: "ACE API DOCUMENTATION",
			    description: "Documentation API Version 1.0",
			    contact_name: "Le Sy Thang",
			    contact_email: "sythang11@gmail.com",
			    contact_url: "https://github.com/sythang"
			  },
			  api_version: 'v1'
		end
	end
end