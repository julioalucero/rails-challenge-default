require 'rails_helper'

RSpec.describe UserQueries::Base do
  describe '#call' do
    let(:full_name) { 'Emmet Brown' }
    let(:metadata) { 'male, age 68, doctor' }
    let(:email) { 'back-to-future@example.com' }

    let!(:success_query_result_user) { create(:user, full_name: full_name, metadata: metadata, email: email) }
    let!(:user_2) { create(:user) }
    let!(:user_3) { create(:user) }

    context 'when all parameters are provided' do
      it 'returns users matching the criteria' do
        query = described_class.new(full_name: full_name, metadata: metadata, email: email).call

        expect(query).to include(success_query_result_user)
        expect(query).not_to include(user_2, user_3)
      end

      it 'orders users by created_at in descending order' do
        query = described_class.new(email: 'example').call

        expect(query).to eq([user_3, user_2, success_query_result_user])
      end
    end

    context 'when some parameters are blank or nil' do
      it 'do not use the full_name on the search' do
        query = described_class.new(full_name: nil, metadata: metadata, email: email).call

        expect(query).to include(success_query_result_user)
        expect(query).to_not include(user_2, user_3)
      end

      it 'do not use the metadata on the search' do
        query = described_class.new(full_name: full_name, metadata: nil, email: email).call

        expect(query).to include(success_query_result_user)
        expect(query).to_not include(user_2, user_3)
      end

      it 'do not use the email on the search' do
        query = described_class.new(full_name: full_name, metadata: metadata, email: '').call

        expect(query).to include(success_query_result_user)
        expect(query).to_not include(user_2, user_3)
      end
    end
  end
end
