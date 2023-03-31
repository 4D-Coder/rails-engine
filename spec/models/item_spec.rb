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
        @item1 = create(:item)
        @item2 = create(:item)
        
        @invoice1 = create(:invoice) # Two items
        @invoice2 = create(:invoice) # Two items

        # Making sure @item1 is on both invoices
        @ii1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 6, unit_price: @item1.unit_price)
        @ii2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 2, unit_price: @item1.unit_price)
        @ii3 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 28, unit_price: @item1.unit_price)
      end

      it 'finds all invoices of an item where there is only one' do
        expect(@item1.find_single_item_invoices.first).to eq(@invoice1)
        expect(@item1.find_single_item_invoices).to_not include(@invoice2)
      end
    end
  end
end
