class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(find_merchant.items)
  end

  private

  def items_params
    params.permit(
      :merchant_id
    )
  end

  def find_merchant
    Merchant.find(items_params[:merchant_id])
  end
end