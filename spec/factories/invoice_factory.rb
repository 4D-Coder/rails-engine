FactoryBot.define do
  factory :invoice do
    status { ["pending", "shipped"].sample }
    merchant
    customer
  end
end