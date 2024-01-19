FactoryBot.define do
  factory :customer_subscription do
    customer_id { Faker::Number.number(digits: 1) }
    subscription_id { Faker::Number.number(digits: 1) }
  end
end
