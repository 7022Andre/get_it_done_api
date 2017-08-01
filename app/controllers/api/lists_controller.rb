class Api::ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    lists = User.find(params[:user_id]).lists
    render json: lists, each_serializer: ListSerializer
  end
  
  def create
    list = List.new(list_params)
    list.user_id = params[:user_id]

    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    list = User.find(params[:user_id]).lists.find(params[:id])

    if list.destroy
      render json: { message: "List removed" }, status: :ok
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :public)
  end
end
