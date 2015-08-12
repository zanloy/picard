FactoryGirl.define do
  factory :tagging do
    tag
    association :taggable, factory: :engineering_change
  end
end
