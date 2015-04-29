FactoryGirl.define do
  factory :notification do
    on_new_user false
    on_new_change false
    on_new_event false

    trait :on_new_user do
      on_new_user true
    end

    trait :on_new_change do
      on_new_change true
    end

    trait :on_new_event do
      on_new_event true
    end
  end
end
