class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

  validates :name, :description, :unit_price, :merchant_id, presence: true
  validates :unit_price, :merchant_id, numericality: true
end
