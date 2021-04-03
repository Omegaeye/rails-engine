FactoryBot.define do
  factory :merchant do

    sequence :name do |n|
      "Merchant #{Faker::Name.name}"
    end
  end
end
