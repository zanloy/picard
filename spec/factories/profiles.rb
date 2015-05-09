FactoryGirl.define do
  factory :profile do
    address { FFaker::Address.street_address }
    company 'Sparc, LLC'
    phone { FFaker::PhoneNumber.phone_number }
    im_address { FFaker::Internet.email }
    va_email { FFaker::Internet.email }
    slack_username 'tester'
  end
end
