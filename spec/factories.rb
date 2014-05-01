FactoryGirl.define do
  factory :organization do
    name "Brewhouse"
    headline "This is the headline"
    description "This is the description"
    founded Date.today
    approved true
  end

  factory :address do
    association :organization_id, :factory => :organization
    address1 "123 Example Street"
    state "BC"
    country "Canada"
    zip "V1A2B3"
  end
end
