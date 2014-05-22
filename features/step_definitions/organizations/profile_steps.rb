Given "I am an admin user" do
  step %|I visit the profile page|
  step %|I claim the profile|
  step %|I login with "Twitter"|
  step %|I submit an email address|
  step %|I visit the profile page|
end

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

When(/^I edit the profile$/) do
  find('span.glyphicon-edit').click
  current_path.should == edit_organization_path(@organization)
end

When(/^I add a profile link for "(.*?)" with name "(.*?)"$/) do |url, name|
  fill_in "profile_link_name", with: name
  fill_in "profile_link_url", with: url
  click_button "Add Link"
end

Then(/^I should see the "(.*?)" link on the profile$/) do |name|
  page.should have_content(name)
end

When(/^I delete the link$/) do
  within('.links-table') do
    find('span.glyphicon-remove').click
  end
end

Then(/^I should not see the "(.*?)" link on the profile$/) do |name|
  page.should_not have_content(name)
  expect(@organization.reload.profile_links).to be_empty
end

When(/^I toggle the hiring box$/) do
  check('hiring')
end

Then(/^the organization should be hiring$/) do
  # visit edit_organization_path(@organization)
  page.should have_css('#label-hiring')
end

Then(/^the organization should not be hiring$/) do
  # visit edit_organization_path(@organization)
  page.should_not have_css('#label-hiring')
end
