class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  private

  def items_params
    params.permit(
      
    )
  end
end