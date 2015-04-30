FactoryGirl.define do
  factory :comment do
    comment 'This is an amazing comment.'

    trait :invalid do
      comment nil
    end
  end
end
