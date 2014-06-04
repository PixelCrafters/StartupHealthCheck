def search_for_keywords(keywords)
  visit "/"
  fill_in "home-page-search", :with => keywords
  click_button "Search"
end

Given(/^there are organizations available$/) do
  @organization = FactoryGirl.create(:organization, name: 'Brewhouse')
  FactoryGirl.create(:organization, name: 'Web Startup 1')
  FactoryGirl.create(:organization, name: 'Web Startup 2')
  Organization.reindex
end

Given(/^a type named "(.*?)"$/) do |type_name|
  type = FactoryGirl.create(:type, name: type_name)
  @organization.types << type
  Organization.reindex
end

When(/^I search for "(.*?)"$/) do |keywords|
  visit "/"
  search_for_keywords(keywords)
end

When(/^I click on the first result for "(.*?)"$/) do |name|
  click_link name
end

When(/^I select the type "(.*?)"$/) do |type_name|
  visit "/"
  select type_name, from: "type_ids"
  click_button "Search"
end

Then(/^I should see search results for "(.*?)"$/) do |keywords|
  page.should have_content(keywords)
end

Then(/^I should see (\d+) result\(s\)$/) do |count|
  if count.to_i > 0
    page.should have_css("#organizations > .search-result", :count => count.to_i)
  else
    page.should_not have_css("#organizations")
  end
end

Then(/^I should be on the profile page for "(.*?)"$/) do |name|
  page.should have_content(name)
end
