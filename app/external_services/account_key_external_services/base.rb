module AccountKeyExternalServices
  class Base
    ROOT_URL = 'https://w7nbdj3b3nsy3uycjqd7bmuplq0yejgw.lambda-url.us-east-2.on.aws/v1/account'.freeze

    attr_accessor :email, :key

    def initialize(email:, key:)
      @email = email
      @key = key
    end

    # TODO: handle errors, log error or success
    def call
      user.update!(account_key: request.body['account_key']) if request.success?
    end

    private

    def request
      Faraday.post(ROOT_URL) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = body
      end
    end

    def body
      { email: email, key: key }.to_json
    end
  end
end
