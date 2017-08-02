class Api::ItemsController < ApplicationController
  before_action :authenticate_user!

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
    if user_authorized?
      find_item

      if @item.update(item_params)
        render json: @item
      else
        render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
      end

    else
        not_authorized
    end
  end

  def destroy
    find_item

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

  def find_item
    @item = Item.find_by_list_id_and_id(params[:list_id], params[:id])
  end

  def user_authorized?
    list = 
    current_user.id == params[:user_id].to_i
  end
end
