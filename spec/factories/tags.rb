# frozen_string_literal: true
FactoryGirl.define do
  factory :tag do
    name { FFaker::Lorem.word }
    initialize_with { Tag.find_or_create_by(name: name) }
  end
end
