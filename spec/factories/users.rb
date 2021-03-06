# frozen_string_literal: true
FactoryBot.define do
  factory :user, aliases: [:poc] do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    new_password '1qazxsw2#EDCVFR$'
    enabled true
    admin false

    after(:build) do |user|
      user.profile ||= FactoryBot.build(:profile)
    end

    trait :disabled do
      enabled false
    end

    trait :banned do
      banned true
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
