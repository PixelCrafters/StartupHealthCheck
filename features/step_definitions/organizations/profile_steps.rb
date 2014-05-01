Given(/^an organization named "(.*?)"$/) do |name|
  @organization = FactoryGirl.create(:organization, name: name)
end

When(/^I visit the profile page$/) do
  FactoryGirl.create(:address, organization_id: @organization.id)
  visit organization_path(@organization)
end

Then(/^I should see the organization's profile$/) do
  page.should have_content(@organization.name)
end

Then(/^I should see the organization's address$/) do
  page.should have_content(@organization.main_address.address1)
end
