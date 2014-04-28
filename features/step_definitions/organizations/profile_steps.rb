Given(/^an organization named "(.*?)" with slug "(.*?)"$/) do |name, slug|
  @organization = FactoryGirl.create(:organization, name: name, slug: slug)
end

When(/^I visit this page$/) do
  visit organization_path(@organization)
end

Then(/^I should see the organizations profile$/) do
  page.should have_content(@organization.name)
end
