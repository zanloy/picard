FactoryGirl.define do
  factory :engineering_change do
    title 'Restarted all servers.'
    self.when { Time.now }
    description { FFaker::BaconIpsum.words(500) }

    trait :invalid do
      title nil
    end
  end
end
