Given(/^the organization has a profile page$/) do
  organization = FactoryGirl.create(:organization)
  visit organization_path(organization)
end

When(/^I visit this page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the organizations profile$/) do
  pending # express the regexp above with the code you wish you had
end
