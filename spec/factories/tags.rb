# frozen_string_literal: true
FactoryBot.define do
  factory :tag do
    name { FFaker::Lorem.word }
    initialize_with { Tag.find_or_create_by(name: name) }
  end
end
