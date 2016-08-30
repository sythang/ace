require 'rails_helper'

describe "API::V1::Users" do
  describe 'POST /api/v1/users/sign_in' do
    context 'passing valid parameters' do
      it "return auth info and api_token" do

        user = create(:user, password: "12341234")
        post "/api/v1/users/sign_in", 
        params: {
          email: user.email,
          password: '12341234'
        }

        expect(json_response).to have_key(:id)
        expect(json_response).to have_key(:name)
        expect(json_response).to have_key(:api_token)
        expect(json_response).to have_key(:email)
        expect(json_response).to have_key(:role)
        expect(json_response).to have_key(:name)
        expect(response.status).to eq 201
      end
    end
    context 'passing invalid parameters' do
      it "return error and message email or password is incorrect" do

        user = create(:user, password: "12341234")
        post "/api/v1/users/sign_in", 
        params: {
          email: user.email,
          password: '12341231'
        }

        expect(json_response).to have_key(:error)
        expect(json_response[:error]).to be_kind_of(Hash)
        expect(json_response[:error]).to have_key(:code)
        expect(json_response[:error][:code]).to be_kind_of(String)
        expect(json_response[:error]).to have_key(:message)
        expect(json_response[:error][:message]).to be_kind_of(String)
        expect(json_response[:error][:message]).to eq("Email or Password is incorrect")
        expect(response.status).to eq 400
      end

      it "return error and message email or password is incorrect" do

        user = create(:user, password: "12341234")
        post "/api/v1/users/sign_in", 
        params: {
          email: user.email+"1",
          password: '123412314'
        }

        expect(json_response).to have_key(:error)
        expect(json_response[:error]).to be_kind_of(Hash)
        expect(json_response[:error]).to have_key(:code)
        expect(json_response[:error][:code]).to be_kind_of(String)
        expect(json_response[:error]).to have_key(:message)
        expect(json_response[:error][:message]).to be_kind_of(String)
        expect(json_response[:error][:message]).to eq("Email or Password is incorrect")
        expect(response.status).to eq 400
      end
    end
  end
end