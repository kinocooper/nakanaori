FactoryBot.define do
  factory :discuss_record do
    title {Faker::Lorem.characters(number:5)}
    detail {Faker::Lorem.characters(number:30)}

    association :pair
  end
end
