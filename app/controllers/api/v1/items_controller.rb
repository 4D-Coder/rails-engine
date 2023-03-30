class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(all_items)
  end

  def show
    render json: ItemSerializer.new(find_item(items_params[:id]))
  end

  def create
    new_item = Item.new(items_params)

    if new_item.valid?
      new_item.save
      render json: ItemSerializer.new(new_item), status: :created
    else
      render json: {errors: new_item.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    item = find_item(items_params[:id])

    begin
      destroy_single_item_invoices(item)
      render json: Item.delete(item.id), status: :no_content
    rescue ActiveRecord::InvalidForeignKey
      render json: {error: item.errors.full_messages}
    end
  end

  private
  def destroy_single_item_invoices(item)
    item.invoices.find_single_item_invoices.destroy_all
  end

  def find_item(id)
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
