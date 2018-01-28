# frozen_string_literal: true
FactoryBot.define do
  factory :list_item do
    list
    payload { JSON.generate({ cn: FFaker::Internet.http_url, expires_on: Date.today })}
    association :updated_by, factory: :user
  end
end
