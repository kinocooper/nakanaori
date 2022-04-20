FactoryBot.define do
  factory :user do
    name {Faker::Lorem.characters(number:5)}

    # 外部キー
    association :pair
    # association :partner
  end
end
