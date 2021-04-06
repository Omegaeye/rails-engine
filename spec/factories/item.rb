FactoryBot.define do
  factory :item do
    sequence :id do |n|
      n
    end
    sequence :name do |n|
      "Item #{Faker::Vehicle.make}"
    end
    description { Faker::Vehicle.model }
    sequence :unit_price do |n|
      n * 2
    end
    merchant
  end
end
