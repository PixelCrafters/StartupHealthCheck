
When(/^I add my role "(.*?)"$/) do |role_name|
  click_link "Add Role"
  fill_in "role_name", with: role_name
  click_button "Submit"
end

Then(/^I should see my role "(.*?)"$/) do |role_name|
  expect(page).to have_content(role_name)
end

When(/^I go to my profile page$/) do
  visit user_path(@organization.users.first)
end
