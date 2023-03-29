class Api::V1::MerchantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: MerchantSerializer.new(all_merchants)
  end

  def show
    render json: MerchantSerializer.new(find_merchant(params[:id])).serializable_hash
  end

  private

  def all_merchants
    @_all_merchants ||= Merchant.all
  end

  def find_merchant(id)
    all_merchants.find(id)
  end

  def not_found
    render json: { error: "404, Not Found" }, status: :not_found
  end
end
