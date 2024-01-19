FactoryBot.define do
  factory :subscription do
    title { Faker::FunnyName.name }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    status { Faker::Color.color_name }
    frequency { Faker::Number.number(digits: 1) }
  end
end
