FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    enabled true
    admin false

    trait :disabled do
      enabled false
    end

    trait :admin do
      admin true
    end
  end
end
