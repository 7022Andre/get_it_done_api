class Api::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer
  end

  def create
    user = User.new(user_params)
    
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])

    if user.destroy
      render json: { message: "User removed" }, status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
