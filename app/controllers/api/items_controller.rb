class Api::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_authorized?, only: [:update, :destroy]

  def index
    items = List.find(params[:list_id]).items
    render json: items, each_serializer: ItemSerializer
  end
  
  def create
    item = Item.new(item_params)
    item.list_id = params[:list_id]

    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find_by_list_id_and_id(params[:list_id], params[:id])

    if @item.update(item_params)
      render json: @item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])

    if @item && @item.destroy
      render json: { message: "Item deleted."}, status: :ok
    else
      record_not_found
    end
  end

  private

  def item_params
    params.require(:item).permit(:body, :completed)
  end

  def user_authorized?
    item = Item.find(params[:id])
    current_user == item.list.user || not_authorized
  end
end
