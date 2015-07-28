FactoryGirl.define do
  factory :alert do
    list
    field { list.date_fields.sample }
    operator { Alert::OPERATORS.sample }
    value 30
  end

end
