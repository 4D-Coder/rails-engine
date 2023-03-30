FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { ["pending", "packaged", "shipped"].sample }
  end
end