require 'spec_helper'

describe Search do
  let!(:brewhouse) { FactoryGirl.create(:organization, name: "brewhouse software") }
  let!(:fullstack) { FactoryGirl.create(:organization, name: "fullstack") }
  let!(:caliper)   { FactoryGirl.create(:organization, name: "caliper")   }
  let!(:gastownlabs) { FactoryGirl.create(:organization, name: "gastownlabs") }
  let!(:steamclock_software) {FactoryGirl.create(:organization, name: "steamclock software")}

  let!(:boris) { FactoryGirl.create(:user, name: "boris") }
  let!(:kalv) { FactoryGirl.create(:user, name: "kalv") }
  let!(:jenn) { FactoryGirl.create(:user, name: "jenn") }

  let!(:startup) { Type.create!(name: "Startup") }
  let!(:service_provider) { Type.create!(name: "Service Provider") }

  before do
    brewhouse.tag_list.add(%w(agency rails software))
    fullstack.tag_list.add(%w(incubator))
    caliper.tag_list.add(%w(rails js software))
    gastownlabs.tag_list.add(%w(agency rails))
    steamclock_software.tag_list.add(%w(ios js))

    boris.tag_list.add(%w(software))
    kalv.tag_list.add(%w(software developer rails js))
    jenn.tag_list.add(%w(software developer rails))

    brewhouse.types << startup
    brewhouse.types << service_provider
    caliper.types << startup
    steamclock_software.types << service_provider

    brewhouse.save!
    fullstack.save!
    caliper.save!
    gastownlabs.save!
    steamclock_software.save!
    boris.save!
    kalv.save!
    jenn.save!

    Organization.reindex
    User.reindex

    # Ensure things are properly setup

    brewhouse.reload
    boris.reload
    expect(brewhouse.tag_list).to include "agency"
    expect(brewhouse.tag_list).to include "rails"

    expect(boris.tag_list).to include "software"
  end

  describe "#call" do
    it "returns brewhouse when I search for brewhouse" do
      r = Search.call(query: "brewhouse")
      expect(r).to eq([brewhouse])
    end

    it "returns nothing when I search for tesla" do
      r = Search.call(query: "tesla")
      expect(r).to be_empty
    end

    it "returns fullstack for the tag incubator" do
      r = Search.call(tags: ["incubator"])
      expect(r).to eq([fullstack])
    end

    it "returns caliper and kalv for the tag rails" do
      r = Search.call(tags: ["js"])
      expect(r).to eq([caliper, steamclock_software, kalv])
    end

    it "returns steamclock software for the tags js, ios" do
      r = Search.call(tags: ["js", "ios"])
      expect(r).to eq([steamclock_software])
    end

    it "returns brewhouse for type Startup" do
      r = Search.call(types: [startup.id])
      expect(r).to eq([brewhouse, caliper])
    end

    it "returns brewhouse for type Startup and the tag agency" do
      r = Search.call(tags: ["agency"], types: [startup.id])
      expect(r).to eq([brewhouse])
    end

    it "returns steamclock software for query software and tag ios" do
      r = Search.call(query: "software", tags: ["ios"])
      expect(r).to eq([steamclock_software])
    end

    it "returns steamclock software for query software and tag ios and type service provider" do
      r = Search.call(query: "software", tags: ["ios"], types: [service_provider.id])
      expect(r).to eq([steamclock_software])
    end
  end
end
