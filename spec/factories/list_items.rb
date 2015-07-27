FactoryGirl.define do
  factory :list_item do
    list
    payload { JSON.generate({ cn: FFaker::Internet.http_url, expires_on: Time.now.to_s })}
    association :updated_by, factory: :user
  end
end
