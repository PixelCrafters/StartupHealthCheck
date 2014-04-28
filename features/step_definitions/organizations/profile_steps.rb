Given(/^an organization named "(.*?)"$/) do |name|
  @organization = FactoryGirl.create(:organization, name: name)
end

When(/^I visit this page$/) do
  visit organization_path(@organization)
end

Then(/^I should see the organizations profile$/) do
  pending # express the regexp above with the code you wish you had
end
