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

When(/^I claim the profile$/) do
  click_link "click here"
end

Then(/^I should be the organization's admin user$/) do
  expect(@organization.users.first).to_not be_nil
end

Then(/^I should see the organization on my profile$/) do
  page.should have_content(@organization.name)
end

When(/^I add a profile link for "(.*?)"$/) do |url|
  fill_in "profile_link_url", with: url
  click_button "Add Link"
end

Then(/^I should see the "(.*?)" link on the profile$/) do |url|
  page.should have_content(url)
end
