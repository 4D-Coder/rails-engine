class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items, dependent: :destroy

  validates :name, :description, :unit_price, :merchant_id, presence: true
  validates :unit_price, :merchant_id, numericality: true
  
  def find_single_item_invoices
    invoices.joins(:invoice_items)
    .group('invoices.id')
    .having('count(invoice_items.id) = 1')
  end
end
