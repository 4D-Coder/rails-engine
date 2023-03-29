class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(all_items)
  end

  private

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
