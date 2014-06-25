require 'spec_helper'

describe Tag::Create do
  describe "#call" do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:organization) { FactoryGirl.create(:organization) }
    let(:tag_name) { "startup" }

    context "taggable is an organization" do
      it "should return the tag name after adding the tag to the organization's tag list" do
        result = Tag::Create.call(tag_name, organization, current_user)
        expect(result).to eq tag_name
        organization.reload
        expect(organization.tags.last.name).to eq tag_name
      end
    end

    context "taggable is a user" do
      it "should return the tag name after adding the tag to the user's tag list" do
        result = Tag::Create.call(tag_name, current_user, current_user)
        expect(result).to eq tag_name
        current_user.reload
        expect(current_user.tags.last.name).to eq tag_name
      end
    end
  end
end
