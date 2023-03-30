FactoryBot.define do
  factory :invoice do
    status { ["pending", "shipped"].sample }
    merchant
    customer

    after(:create) do |invoice|
      create(:item, invoices: [invoice])
    end
  end
end