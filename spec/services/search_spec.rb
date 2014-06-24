require 'spec_helper'

describe Search do
  describe "#call" do

    context "keyword 'software'" do
      it "should return a set of results" do
        organization1 = Organization.create(name: "Brewhouse Software")
        organization2 = Organization.create(name: "Example Sofware Company")
        params = {
         "query"=>"software",
         "type"=>{"ids"=>[""]},
         "tag"=>{"names"=>[""]}
        }
        Organization.reindex
        User.reindex
        results = Search.call(params)
        expect(results.count).to eq 2
      end
    end

    context "tagged with 'software'" do
      it "should return a set of results" do
        organization1 = Organization.create(name: "Brewhouse Software")
        organization2 = Organization.create(name: "Example Sofware Company")
        params = {
         "query"=>"",
         "type"=>{"ids"=>[""]},
         "tag"=>{"names"=>["", "software"]}
        }
        organization1.tag_list.add('software')
        organization1.save
        organization2.tag_list.add('software')
        organization2.save
        Organization.reindex
        User.reindex
        results = Search.call(params)
        expect(results.count).to eq 2
      end
    end
  end
end
