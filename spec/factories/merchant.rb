FactoryBot.define do
  factory :merchant do
    sequence :id do |i|
      "#{i}"
    end

    sequence :name do |n|
      "Merchant #{Faker::Name.name}"
    end
  end
end
