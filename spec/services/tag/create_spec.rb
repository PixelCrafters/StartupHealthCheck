require 'spec_helper'

describe Tag::Create do
  describe "#call" do
    let(:current_user) { FactoryGirl.build(:user) }
    it "should add the tag to the organization's tag list" do
      organization = FactoryGirl.build(:organization)
      tag_name = "startup"
      result = Tag::Create.call(tag_name, organization, current_user)
      expect(result).to eq tag_name
    end
  end
end
