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
end
