# frozen_string_literal: true
FactoryGirl.define do
  factory :subscription do
    user
    association :subscribable, factory: :engineering_change
  end
end
