require 'rails_helper'

RSpec.describe User, type: :model do
  let(:attributes) do
    {
      email: "user@example.com",
      phone_number: "1234567890",
      full_name: "Test User",
      password: "password",
      key: SecureRandom.hex(10),
      account_key: SecureRandom.hex(10),
      metadata: "Some metadata"
    }
  end

  subject { User.new(attributes) }

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:email).is_at_most(User::EMAIL_LENGTH) }

    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:phone_number).case_insensitive }
    it { should validate_length_of(:phone_number).is_at_most(User::PHONE_NUMBER_LENGTH) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_most(User::STRING_LENGTH) }

    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:key) }
    it { should validate_length_of(:key).is_at_most(User::STRING_LENGTH) }

    it { should validate_uniqueness_of(:account_key).allow_blank }
    it { should validate_length_of(:account_key).is_at_most(User::STRING_LENGTH) }

    it { should validate_length_of(:metadata).is_at_most(User::METADATA_LENGTH) }
  end

  describe 'scopes' do
    let(:full_name) { 'Emmet Brown' }
    let(:metadata) { 'male, age 68, doctor' }
    let(:email) { 'back-to-future@example.com' }

    let!(:success_query_result_user) { create(:user, full_name: full_name, metadata: metadata, email: email) }
    let!(:user_2) { create(:user) }
    let!(:user_3) { create(:user) }

    describe '.by_full_name' do
      it 'returns users matching the full_name' do
       query = User.by_full_name(full_name)

        expect(query).to include(success_query_result_user)
        expect(query).not_to include(user_2, user_3)
      end

      it 'returns all users when full_name is blank' do
        expect(User.by_full_name(nil)).to include(success_query_result_user, user_2, user_3)
        expect(User.by_full_name('')).to include(success_query_result_user, user_2, user_3)
      end
    end

    describe '.by_metadata' do
      it 'returns users matching the metadata' do
        expect(User.by_metadata('doctor')).to include(success_query_result_user)
        expect(User.by_metadata('doctor')).not_to include(user_2, user_3)
      end

      it 'returns all users when metadata is blank' do
        expect(User.by_metadata(nil)).to include(success_query_result_user, user_2, user_3)
        expect(User.by_metadata('')).to include(success_query_result_user, user_2, user_3)
      end
    end

    describe '.by_email' do
      it 'returns users matching the email' do
        expect(User.by_email(email)).to include(success_query_result_user)
        expect(User.by_email(email)).not_to include(user_2, user_3)
      end

      it 'returns all users when email is blank' do
        expect(User.by_email(nil)).to include(success_query_result_user, user_2, user_3)
        expect(User.by_email('')).to include(success_query_result_user, user_2, user_3)
      end
    end
  end
end
