FactoryBot.define do
  factory :item do
    name {Faker::Cannabis.strain}
    description {Faker::Cannabis.health_benefit}
    unit_price {Faker::Number.decimal(l_digits: 2, r_digits: 2)}
    merchant
  end
end