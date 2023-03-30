require "rails_helper"

RSpec.describe Item, type: :model do
  describe "associations" do
    it { should belong_to :merchant }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id } 
    it { should validate_numericality_of :merchant_id }
    it { should validate_numericality_of :unit_price }
  end

  describe '#instance methods' do
    context '#find_single_item_invoices' do
      before(:each) do
        @new_item = create(:item)
        @invoice1 = create(:invoice) # Two items
        @invoice2 = create(:invoice) # Two items

        # Making sure the @new_item is on both invoices
        InvoiceItem.create!(item_id: @new_item.id, invoice_id: @invoice1.id, quantity: 6, unit_price: @new_item.unit_price)
        InvoiceItem.create!(item_id: @new_item.id, invoice_id: @invoice2.id, quantity: 2, unit_price: @new_item.unit_price)
      end
      it 'finds all invoices of an item where there is only one' do
        require 'pry'; binding.pry
        @invoice2.items.last.delete
        expect(@new_item.find_single_item_invoices).to eq(@invoice1)
        expect(@new_item.find_single_item_invoices).to_not include(@invoice2)
      end
    end
  end
end
