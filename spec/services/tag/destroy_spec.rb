require 'spec_helper'

describe Tag::Destroy do
  describe "#call" do
    current_user = FactoryGirl.build(:user)
    organization = FactoryGirl.build(:organization)
    
    it "should remove the tag from the organization's tag_list" do
      organization.tag_list.add('startup')
      organization.save
      tag = ActsAsTaggableOn::Tag.last

      result = Tag::Destroy.call(tag.id, organization, current_user)
      
      expect(result).to eq tag
      expect(organization.tag_list.split(',').last).to_not eq tag.name
    end
  end
end
