When(/^I go to the activity stream page$/) do
  visit activities_path
end

Then(/^I should see the "(.*?)" activity$/) do |name|
  expect(page).to have_content(name)
end
