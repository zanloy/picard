# frozen_string_literal: true
FactoryBot.define do
  factory :list do
    name { FFaker::BaconIpsum.words(5).join(' ') }
    description { FFaker::BaconIpsum.words(500).join(' ') }
    schema { JSON.generate({ cn: "string", expires_on: "date" }) }
    association :last_added_by, factory: :user
    last_added_on "2015-07-24"

    trait :invalid do
      name nil
    end
  end
end
