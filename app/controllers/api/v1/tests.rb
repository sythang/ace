module API
	module V1
		class Tests < API::V1::Default
			before { authorize_api! }
			resource :tests do
				desc "Get List tests" do
					failure [[400, 'Unauthorized', API::V1::Entities::Error]]
	        headers 'Http-Auth-Token' => { description: 'API Token', required: true }
	        success API::V1::Entities::Test
				end
				params do
					use :pagination
				end
				get do
					tests =Test.page(params[:page]).per(params[:per])
					present tests, with: API::V1::Entities::Test
				end

				desc "Get List tests" do
					failure [[408, 'Unauthorized', API::V1::Entities::Error]]
	        headers 'Http-Auth-Token' => { description: 'API Token', required: true }
	        success API::V1::Entities::TestDetail
				end
				get ':id' do
					test = Test.find(params[:id])
					present test, with: API::V1::Entities::TestDetail
				end

				desc "Save Test result" do
					failure [[400, 'Unauthorized', API::V1::Entities::Error]]
	        headers 'Http-Auth-Token' => { description: 'API Token', required: true }
	        success API::V1::Entities::Success
				end
				params do
					requires :test_id, type: Integer
					requires :answers, type: Array do
						requires :question_id, type: Integer
						requires :option_id, type: Integer
					end
				end
				post :submit do
					answer_question_service = SubmitAnswer.new(current_user, params)
					if answer_question_service.submit
						present Hash(message: "Submitted", code: 'submit_answer'), with: API::V1::Entities::Success
					else
						error!({ message: answer_question_service.error, code: 'unauthorized', with: API::V1::Entities::Error }, 400)
					end
				end

			end
		end
	end
end