require 'spec_helper'

describe StartupGenome::UpdateAddress do

  ORG_HASH = {
    "id" => "127239",
    "name" => "285 Digital Media",
    "headline" => "",
    "description" => "A software development company based in Vancouver Canada specializing in Web, Mobile, and Games.<br /><br />285&#8217;s flagship product is Direct Feed - a mobile application platform for restaurants.",
    "founded" => "1267423200",
    "size" => nil,
    "hiring_url" => "",
    "active" => "1",
    "approved" => "1",
    "slug" => "285-digital-media",
    "organization_id" => "127239",
    "url" => "http://startupgenome.co/285-digital-media",
    "categories" => [
        {
            "category_id" => 2,
            "plural_name" => "Startups",
            "singular_name" => "Startup",
            "slug" => "startups"
        }
    ],
    "latitude" => "49.2763634",
    "longitude" => "-123.1186295",
    "zip" => "V6B 2E2",
    "address1" => "280 Nelson St",
    "address2" => "Vancouver B.C. Canada",
    "state" => "British Columbia",
    "country" => "Canada"
  }

  describe "#call" do
    let(:organization) { FactoryGirl.build(:organization) }
    it "should create the address" do
      address = StartupGenome::UpdateAddress.call(ORG_HASH, organization)
      expect(address.persisted?).to eq true
    end

    it "should update the organization" do
      address = StartupGenome::UpdateAddress.call(ORG_HASH, organization)

      hash_dupe = ORG_HASH.dup
      hash_dupe['address1'] = "whatever"

      address = StartupGenome::UpdateAddress.call(hash_dupe, organization)
      expect(address.address1).to eq "whatever"
    end
  end

end
