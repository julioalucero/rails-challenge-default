module UserQueries
  class Base
    attr_accessor :full_name, :metadata, :email

    def initialize(full_name: nil, metadata: nil, email: nil)
      @full_name = full_name
      @metadata  = metadata
      @email     = email
    end

    def call
      User.by_full_name(full_name)
          .by_metadata(metadata)
          .by_email(email)
          .order(created_at: :desc)
    end
  end
end
