require 'spec_helper'

describe Tag::Create do
  describe "#call" do
    current_user = FactoryGirl.build(:user)
    organization = FactoryGirl.build(:organization)
    tag_name = "startup"

    it "should add the tag to the organization's tag list" do
      result = Tag::Create.call(tag_name, organization, current_user)
      expect(result).to eq tag_name
    end
  end
end
