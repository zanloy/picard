# frozen_string_literal: true
FactoryBot.define do
  factory :environment do
    name 'Production'
    domain { FFaker::Internet.domain_name }

    trait :preprod do
      name 'Pre-Prod'
    end
  end
end
