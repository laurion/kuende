FactoryGirl.define do
  factory :identity do |f|
    f.id "123"
    f.email "test@example.com"
    f.password "my-password"
  end

  factory :user do |f|
    f.id "1"
    f.provider "identity"
    f.uid "123"
  end
end