require 'spec_helper'

describe Tag::Destroy do
  describe "#call" do
    current_user = FactoryGirl.build(:user)
    organization = FactoryGirl.build(:organization)

    context "organization exists" do
      it "should remove the tag from the organization's tag_list and return the removed tag" do
        organization.tag_list.add('startup')
        organization.save
        tag = ActsAsTaggableOn::Tag.last

        result = Tag::Destroy.call(tag.id, organization, current_user)
        
        expect(result).to eq tag
        expect(organization.tag_list.split(',').last).to_not eq tag.name
      end
    end

    context "organization is nil" do
      it "should remove the tag from the users's tag_list and return the removed tag" do
        current_user.tag_list.add('startup')
        current_user.save
        tag = ActsAsTaggableOn::Tag.last

        result = Tag::Destroy.call(tag.id, nil, current_user)
        
        expect(result).to eq tag
        expect(current_user.tag_list.split(',').last).to_not eq tag.name
      end
    end
  end
end
