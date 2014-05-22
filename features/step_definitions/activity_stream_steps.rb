When(/^I go to the activity stream page$/) do
  visit activities_path
end

Then(/^I should see the "(.*?)" activity$/) do |activity|
  expect(page).to have_content(activity)
end

Then(/^I should see the claim activity$/) do
  expect(page).to have_content("Twitter User claimed Brewhouse")
end
