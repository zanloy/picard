FactoryGirl.define do
  factory :server do
    name 'proxy001'
    ip_address { FFaker::Internet.ip_v4_address }
    ports '8080/tcp'
  end
end
