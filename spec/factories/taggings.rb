# frozen_string_literal: true
FactoryBot.define do
  factory :tagging do
    tag
    association :taggable, factory: :engineering_change
  end
end
