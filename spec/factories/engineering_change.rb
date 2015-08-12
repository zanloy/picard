FactoryGirl.define do
  factory :engineering_change do
    title { FFaker::BaconIpsum.words(5).join(' ') }
    environment
    poc
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
