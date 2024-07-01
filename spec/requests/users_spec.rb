require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:email) { 'user-0@example.com' }
  let(:phone_number) { '5551235555' }
  let(:key) { '72ae25495a7981c40622d49f9a52e4f1565c90f048f59027bd9c8c8900d5c3d8' }
  let(:account_key) { 'b97df97988a3832f009e2f18663ac932' }

  describe "GET /index" do
    context 'when the params are valid' do
      let(:params) { {} }

      before do
        create(:user, email: email, phone_number: phone_number, key: key, account_key: account_key)
        get users_path, params: params
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

        its(['email'])        { is_expected.to eq(email) }
        its(['phone_number']) { is_expected.to eq(phone_number) }
        its(['full_name'])    { is_expected.to eq("Joe Smith") }
        its(['key'])          { is_expected.to eq(key) }
        its(['account_key'])  { is_expected.to eq(account_key) }
        its(['metadata'])     { is_expected.to eq("male, age 32, unemployed, college-educated") }
      end
    end

    it 'return 422 Unprocessable Entity for unsearchable unsearchable' do
      get users_path, params: { key: true }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'return 422 Unprocessable Entity for not existing ones' do
      get users_path, params: { cellphone: '23048092384' }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST /create" do

    it 'return a http success'

    it 'creates a new user'

    context 'when the creation does not success' do
      it 'returns an Unprocessable Entity with the list of all errors'
    end
  end
end
