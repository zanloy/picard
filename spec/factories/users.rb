FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    new_password '1qazxsw2#EDCVFR$'
    enabled true
    admin false

    trait :disabled do
      enabled false
    end

    trait :admin do
      admin true
    end

    trait :invalid do
      name nil
      email nil
    end
  end
end
