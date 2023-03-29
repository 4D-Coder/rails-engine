FactoryBot.define do
  factory :merchant do
    name {Faker::Name.name}
    association :item
  end
end