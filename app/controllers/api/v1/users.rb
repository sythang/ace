module API
	module V1
		class Users < API::V1::Default
			resource :users do
				desc "API Sign In" do
          failure [[400, 'Unauthorized', API::V1::Entities::Error]]
          success API::V1::Entities::User
        end
        params do
          requires :email, type: String, desc: "User's email"
          requires :password, type: String, desc: "Password"
        end
        post :sign_in do
          auth = UserAuthenticator.new(params[:email], params[:password])
          unless auth.authenticate
            error!({ message: auth.message, code: 'unauthorized', with: API::V1::Entities::Error }, 400)
          end
          present auth.user, with: API::V1::Entities::User, show_api_key: true
        end

        desc "API Sign Out" do
          failure [[400, 'Unauthorized', API::V1::Entities::Error]]
          headers 'Http-Auth-Token' => { description: 'API Token', required: true }
        end
        delete :sign_out do
          authorize_api!
          current_user.update(api_token: nil)
          present Hash(message: "Sign out sucess!", code: 'sign_out'), with: API::V1::Entities::Success
        end
			end
		end
	end
end