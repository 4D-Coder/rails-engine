class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, :description, :unit_price, :merchant_id, presence: true
  validates :unit_price, :merchant_id, numericality: true
end
