# frozen_string_literal: true
FactoryBot.define do
  factory :engineering_change do
    title { FFaker::Company.catch_phrase }
    environment
    association :entered_by, factory: :user
    association :poc, factory: :user
    self.when { Time.now }
    description { FFaker::BaconIpsum.words(500).join(' ') }
    transient do
      tag_count 0
    end

    trait :invalid do
      title nil
    end

    after(:create) do |change, evaluator|
      evaluator.tag_count.times do
        tag = create(:tag)
        create(:tagging, taggable: change)
      end
    end
  end
end
