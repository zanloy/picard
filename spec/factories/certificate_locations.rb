# frozen_string_literal: true
FactoryGirl.define do
  factory :certificate_location do
    server
    certificate
    location "MyString"
  end

end
