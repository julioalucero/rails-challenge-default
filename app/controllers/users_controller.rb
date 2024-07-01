class UsersController < ApplicationController
  API_ROOT = 'users'.freeze
  VALID_PARAMS = [:controller, :action, :full_name, :metadata, :email]
  PERMITED_PARAMS = [:email, :phone_number, :full_name, :password, :metadata]

  before_action :veryfy_param, on: :index

  def index
    users = UserQueries::Base.new(**query_params).call

    render json: users, each_serializer: UserSerializer, root: API_ROOT
  end

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
