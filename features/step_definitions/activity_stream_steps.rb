When(/^I go to the activity stream page$/) do
  visit activities_path
end

Then(/^I should see the "(.*?)" activity$/) do |activity|
  sleep 1
  expect(page).to have_content(activity)
end

Then(/^I should see the claim activity$/) do
  sleep 1
  expect(page).to have_content("J C claimed Brewhouse")
end
