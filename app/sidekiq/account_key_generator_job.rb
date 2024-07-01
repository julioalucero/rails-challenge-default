class AccountKeyGeneratorJob
  include Sidekiq::Job

  sidekiq_options retry: 10

  def perform(email, key)
    AccountKeyExternalServices::Base.new(email: user.email, key: user.key).call
  rescue StandardError => e
    Rails.logger.error "AccountKeyExternalServicesWorker: Failed to process #{email} - #{e.message}"
    raise e # to run the retry
  end
end
