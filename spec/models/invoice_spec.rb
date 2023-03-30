require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "associations" do
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end
end