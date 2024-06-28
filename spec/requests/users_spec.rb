require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    before do
      create(:user)
      get users_path
    end

    subject(:json_response) { JSON.parse(response.body) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct number of users' do
      expect(json_response['users'].length).to eq(1)
    end

    describe 'Return all current user records, most recently created first' do
      subject{ json_response['users'].first }

      its(['email'])        { is_expected.to eq("user@example.com") }
      its(['phone_number']) { is_expected.to eq("5551235555") }
      its(['full_name'])    { is_expected.to eq("Joe Smith") }
      its(['key'])          { is_expected.to eq("72ae25495a7981c40622d49f9a52e4f1565c90f048f59027bd9c8c8900d5c3d8") }
      its(['account_key'])  { is_expected.to eq("b97df97988a3832f009e2f18663ac932") }
      its(['metadata'])     { is_expected.to eq("male, age 32, unemployed, college-educated") }
    end

    # `/api/users?full_name=Smith&metadata=male`.
    context 'when send query parameters' do
      it 'filter results matching `email`, `full_name`, and `metadata`' do
      end

      it 'Return in most recently created first order' do
      end
    end

    # unsearchable fields (ie. `key`) or not existing ones (ie. `cellphone`).
    it 'return 422 Unprocessable Entity for malformed query parameters' do
    end

    it '5xx for server errors' do
    end
  end
end
