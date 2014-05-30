FactoryGirl.define do
  factory :organization do
    name "Brewhouse"
    headline "This is the headline"
    description "This is the description"
    founded Date.today
    approved true
    active true
    claimed false
  end

  factory :address do
    association :organization_id, factory: :organization
    address1 "123 Example Street"
    state "BC"
    country "Canada"
    zip "V1A2B3"
  end

  factory :user do
    name "Example User"
  end

  factory :tag, class: ActsAsTaggableOn::Tag do
    sequence(:id) {|n| n}
    name "startup"
  end
end
