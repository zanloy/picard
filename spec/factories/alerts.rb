# frozen_string_literal: true
FactoryBot.define do
  factory :alert do
    list
    field { (list.respond_to? :date_fields) ? list.date_fields.sample : nil }
    operator { Alert::OPERATORS.sample }
    value 30
  end

end
