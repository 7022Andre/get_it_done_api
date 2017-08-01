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

  private

  def item_params
    params.require(:item).permit(:body)
  end
end
