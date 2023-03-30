class Api::V1::ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
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
      record_invalid(@new_item)
    end
  end

  private

  def item(id)
    all_items.find(id)
  end

  def all_items
    @_all_items ||= Item.all
  end

  def not_found
    render json: { error: "404, Not Found" }, status: :not_found
  end

  def record_invalid(new_item)
    render json: {errors: new_item.errors.full_messages}, status: :unprocessable_entity
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
