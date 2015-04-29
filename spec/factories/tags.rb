FactoryGirl.define do
  factory :tag do
    name { FFaker::BaconIpsum.word }
  end
end
