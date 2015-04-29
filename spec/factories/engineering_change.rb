FactoryGirl.define do
  factory :engineering_change do
    title { FFaker::BaconIpsum.words }
    self.when { Time.now }
    description { FFaker::BaconIpsum.words(500) }
  end
end
