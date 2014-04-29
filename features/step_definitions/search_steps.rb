def search_for_keywords(keywords)
  visit "/"
  fill_in "query", :with => keywords
  click_button "Search"
end

Given(/^there are organizations available$/) do
  FactoryGirl.create(:organization, name: 'Brewhouse')
  FactoryGirl.create(:organization, name: 'Web Startup 1')
  FactoryGirl.create(:organization, name: 'Web Startup 2')
  Organization.reindex
  Organization.searchkick_index.refresh
end

When(/^I search for organization "(.*?)"$/) do |keywords|
  search_for_keywords(keywords)
end

Then(/^I should see search results for "(.*?)"$/) do |keywords|
  page.should have_content(keywords)
end

Then(/^I should see (\d*) result$/) do |count|
  if count.to_i > 0
    page.should have_css("#organizations > .search-result", :count => count.to_i)
  else
    page.should_not have_css("#organizations")
  end
end
