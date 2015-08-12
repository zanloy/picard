FactoryGirl.define do
  factory :comment do
    user
    association :commentable, factory: :engineering_change
    comment 'This is an amazing comment.'

    trait :invalid do
      comment nil
    end
  end
end
