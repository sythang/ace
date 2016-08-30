require 'rails_helper'

describe "API::V1::Tests" do
  let(:user) {  create(:user, api_token: SecureRandom.base64(64)) } 
  describe 'GET /api/v1/tests' do
    context 'passing valid API TOKEN' do
    	it 'return list tests' do
        teacher = create(:user, role: :teacher)
        test = create(:test, teacher_id: teacher.id)
        get "/api/v1/tests",
        params: {},
        headers: sign_in(user)

        expect(json_response).to have_key(:tests)
        expect(json_response[:tests][0]).to have_key(:id)
        expect(json_response[:tests][0]).to have_key(:name)
        expect(json_response[:tests][0]).to have_key(:description)
        expect(response.status).to eq 200
      end
    end

    context 'passing valid API TOKEN' do
      it 'return unauthorize' do
        get "/api/v1/tests",
          params: {},
          headers: {'Http-Auth-Token' => 'invalid_api_token'}

        expect(json_response).to have_key(:error)
        expect(json_response[:error]).to be_kind_of(Hash)
        expect(json_response[:error]).to have_key(:code)
        expect(json_response[:error][:code]).to be_kind_of(String)
        expect(json_response[:error]).to have_key(:message)
        expect(json_response[:error][:message]).to be_kind_of(String)
        expect(json_response[:error][:message]).to eq("Unauthorized. Invalid token.")
        expect(response.status).to eq 401
      end
    end
  end

  describe 'GET /api/v1/tests/:id' do
    context 'passing valid API TOKEN' do
      it "return Test detail" do
        teacher = create(:user, role: :teacher)
        test = create(:test, teacher_id: teacher.id)
        question = create(:question, test_id: test.id)
        option = create(:option, question_id: question.id)
        get "/api/v1/tests/#{test.id}",
        params: {},
        headers: sign_in(user)

        expect(json_response).to have_key(:test)
        expect(json_response[:test]).to have_key(:id)
        expect(json_response[:test]).to have_key(:name)
        expect(json_response[:test]).to have_key(:description)
        expect(json_response[:test][:questions]).to be_kind_of(Array)
        expect(json_response[:test][:questions][0]).to have_key(:id)
        expect(json_response[:test][:questions][0]).to have_key(:label)
        expect(json_response[:test][:questions][0]).to have_key(:description)
        expect(json_response[:test][:questions][0]).to have_key(:options)
        expect(json_response[:test][:questions][0][:options][0]).to have_key(:id)
        expect(json_response[:test][:questions][0][:options][0]).to have_key(:content)
        expect(json_response[:test][:questions][0][:options][0]).to have_key(:is_correct_answer)

        expect(response.status).to eq 200
      end
    end
    context 'passing valid API TOKEN' do
      it 'return unauthorize' do
        teacher = create(:user, role: :teacher)
        test = create(:test, teacher_id: teacher.id)
        question = create(:question, test_id: test.id)
        option = create(:option, question_id: question.id)
        get "/api/v1/tests/#{test.id}",
          params: {},
          headers: {'Http-Auth-Token' => 'invalid_api_token'}

        expect(json_response).to have_key(:error)
        expect(json_response[:error]).to be_kind_of(Hash)
        expect(json_response[:error]).to have_key(:code)
        expect(json_response[:error][:code]).to be_kind_of(String)
        expect(json_response[:error]).to have_key(:message)
        expect(json_response[:error][:message]).to be_kind_of(String)
        expect(json_response[:error][:message]).to eq("Unauthorized. Invalid token.")
        expect(response.status).to eq 401
      end
    end
  end

  describe 'GET /api/v1/tests/submit' do
    context 'passing valid API TOKEN' do
      it 'return Success' do
        teacher = create(:user, role: :teacher)
        test = create(:test, teacher_id: teacher.id)
        question = create(:question, test_id: test.id)
        option = create(:option, question_id: question.id)
        post "/api/v1/tests/submit",
        params: {
          test_id: test.id,
          answers: [{question_id: question.id, option_id: option.id}]
        },
        headers: sign_in(user)

        p json_response
        expect(json_response).to have_key(:code)
        expect(json_response).to have_key(:message)
        expect(json_response[:message]).to eq("Submitted")
        expect(response.status).to eq 201
      end
    end
    context 'passing valid API TOKEN' do
      it 'return unauthorize' do
        post "/api/v1/tests/submit",
          params: {},
          headers: {'Http-Auth-Token' => 'invalid_api_token'}

        expect(json_response).to have_key(:error)
        expect(json_response[:error]).to be_kind_of(Hash)
        expect(json_response[:error]).to have_key(:code)
        expect(json_response[:error][:code]).to be_kind_of(String)
        expect(json_response[:error]).to have_key(:message)
        expect(json_response[:error][:message]).to be_kind_of(String)
        expect(json_response[:error][:message]).to eq("Unauthorized. Invalid token.")
        expect(response.status).to eq 401
      end
    end
  end
end