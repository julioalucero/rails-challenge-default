module Api
  module V1
    class UsersController < BaseController
      API_ROOT = 'users'.freeze
      VALID_PARAMS = [:format, :controller, :action, :full_name, :metadata, :email]
      PERMITED_PARAMS = [:email, :phone_number, :full_name, :password, :metadata]

      before_action :veryfy_param, on: :index

      # Returns users
      #
      # @body_parameter [string] full_name
      # @body_parameter [string] metadata
      # @body_parameter [string] email
      #
      # @response_class UserSerializer
      def index
        users = UserQueries::Base.new(**query_params).call

        render json: users, each_serializer: UserSerializer, root: API_ROOT
      end

      # Register user
      #
      # @body_parameter [string] email
      # @body_parameter [string] phone_number
      # @body_parameter [string] full_name
      # @body_parameter [string] password
      # @body_parameter [string] metadata
      #
      # @response_class UserSerializer
      def create
        user = user_business.create(create_params)

        if user.valid?
          render json: user, serializer: UserSerializer, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def query_params
        {
          full_name: params[:full_name],
          metadata:  params[:metadata],
          email:     params[:email]
        }
      end

      def veryfy_param
        return if params.keys.all? { |key| VALID_PARAMS.include?(key.to_sym) }

        render json: { error: 'Your params are invalid.' }, status: :unprocessable_entity
      end

      def create_params
        params.permit(PERMITED_PARAMS)
      end

      def user_business

      end
    end
  end
end
