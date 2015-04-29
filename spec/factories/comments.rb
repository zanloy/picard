FactoryGirl.define do
  factory :comment do
    comment { FFaker::BaconIpsum.words(10) }
  end
end
