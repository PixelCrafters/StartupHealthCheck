require 'spec_helper'

describe Tag::Destroy do
  describe "#call" do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:organization) { FactoryGirl.create(:organization) }

    context "taggable is an organization" do
      it "should remove the tag from the organization's tag_list and return the removed tag" do
        organization.tag_list.add('startup')
        organization.save
        tag = ActsAsTaggableOn::Tag.last

        result = Tag::Destroy.call(tag.id, organization, current_user)

        expect(result).to eq tag
        expect(organization.tag_list.split(',').last).to_not eq tag.name
      end
    end

    context "taggable is a user" do
      it "should remove the tag from the users's tag_list and return the removed tag" do
        current_user.tag_list.add('startup')
        current_user.save
        tag = ActsAsTaggableOn::Tag.last

        result = Tag::Destroy.call(tag.id, current_user, current_user)

        expect(result).to eq tag
        expect(current_user.tag_list.split(',').last).to_not eq tag.name
      end
    end
  end
end
