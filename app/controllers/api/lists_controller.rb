class Api::ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.id == params[:user_id].to_i
      lists = User.find(params[:user_id]).lists
      render json: lists, each_serializer: ListSerializer
    else
      render json: { message: "You're not authorized to see this list." }, status: :ok
    end
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

  def update
    find_list

    if @list.update(list_params)
      render json: @list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    find_list

    if @list && @list.destroy
      render json: { message: "List removed." }, status: :ok
    else
      record_not_found
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :public)
  end

  def find_list
    @list = List.find_by_user_id_and_id(params[:user_id], params[:id])
  end
end
