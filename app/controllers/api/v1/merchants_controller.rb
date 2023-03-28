class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(all_merchants)
  end

  def show
    render json: MerchantSerializer.new(one_merchant(params[:id])).serializable_hash
  end

  private

  def all_merchants
    @merchants ||= Merchant.all
  end

  def one_merchant(id)
    all_merchants.find(id)
  end
end