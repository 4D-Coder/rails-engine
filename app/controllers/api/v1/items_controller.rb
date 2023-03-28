class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(all_items)
  end

  def show
    render json: ItemSerializer.new(item(items_params[:id]))
  end

  def create
    @new_item = Item.create(items_params)

    if @new_item.save
      render json: ItemSerializer.new(@new_item), status: :created
    else
      # render json: ErrorSerializer.new(@new_item.errors), status:
    end
  end

  def destroy
    Item.destroy(item(items_params[:id]).id)
  end

  private
  def item(id)
    all_items.find(id)
  end

  def all_items
    @_all_items ||= Item.all
  end

  def items_params
    params.permit(
      :id,
      :name,
      :description,
      :unit_price,
      :merchant_id,
      :item
    )
  end
end