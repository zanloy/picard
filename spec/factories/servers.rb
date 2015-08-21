FactoryGirl.define do
  factory :server do
    name "proxy001"
    environment
    ip_address { FFaker::Internet.ip_v4_address }
    ports "80/tcp, 443/tcp"
  end

end
