module Api
  class BaseController < ApplicationController
    before_action :set_default_response_format

    # TODO: consider to handle errors here, for example:
    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    # def record_not_found(exception); render json: { error: exception.message }, status: :not_found

    private

    def set_default_response_format
      request.format = :json
    end
  end
end
