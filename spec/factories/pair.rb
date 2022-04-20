FactoryBot.define do
  factory :pair do
    name {Faker::Lorem.characters(number:5)}
    keyword {Faker::Lorem.characters(number:5)}

  end
end
