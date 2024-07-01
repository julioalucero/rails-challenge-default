module UserBusiness
  class Base
    attr_accessor :full_name, :metadata, :email, :phone_number, :password

    def initialize(full_name:, email:, phone_number:, password:, metadata: nil)
      @full_name    = full_name
      @email        = email
      @phone_number = phone_number
      @password     = password
      @metadata     = metadata
    end

    def create
      user = User.create(full_name)

      AccountKeyExternalServicesWorker.perform_async(user.email, user.key) if user.persisted?

      user
    end

    private

    def create_params
      {
        full_name: full_name,
        email: email,
        phone_number: phone_number,
        password: password,
        metadata: metadata,
        key: SecureRandom.hex(32),
      }
    end
  end
end
