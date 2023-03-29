class Api::V1::MerchantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: MerchantSerializer.new(all_merchants)
  end

  def show
    render json: MerchantSerializer.new(one_merchant(params[:id])).serializable_hash
  end

  private

  def not_found
    render json: {error: "404, Not Found"}, status: :not_found
  end

  def all_merchants
    @merchants ||= Merchant.all
  end

  def one_merchant(id)
    all_merchants.find(id)
  end
end