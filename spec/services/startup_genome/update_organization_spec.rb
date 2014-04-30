require 'spec_helper'

describe StartupGenome::UpdateOrganization do

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
    it "should create the organization" do
      organization = StartupGenome::UpdateOrganization.call(ORG_HASH)
      expect(organization.persisted?).to eq true
    end

    it "should update the organization" do
      organization = StartupGenome::UpdateOrganization.call(ORG_HASH)

      hash_dupe = ORG_HASH.dup
      hash_dupe['url'] = "whatever"

      organization = StartupGenome::UpdateOrganization.call(hash_dupe)
      expect(organization.url).to eq "whatever"
    end
  end

end
