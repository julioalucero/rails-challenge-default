class UsersController < ApplicationController
  def index
    users = User.order(created_at: :desc)

    render json: users, each_serializer: UserSerializer, root: 'users'
  end

  def create
  end
end
