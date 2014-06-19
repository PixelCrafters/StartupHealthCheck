require 'spec_helper'

describe Tag::Create do
  describe "#call" do
    current_user = FactoryGirl.build(:user)
    organization = FactoryGirl.build(:organization)
    tag_name = "startup"

    context "organization exists" do
      it "should return the tag name after adding the tag to the organization's tag list" do
        result = Tag::Create.call(tag_name, organization, current_user)
        expect(result).to eq tag_name
        expect(organization.tags.last.name).to eq tag_name
      end
    end

    context "organization is nil" do
      it "should return the tag name after adding the tag to the user's tag list" do
        result = Tag::Create.call(tag_name, nil, current_user)
        expect(result).to eq tag_name
        expect(current_user.tags.last.name).to eq tag_name
      end
    end
  end
end
