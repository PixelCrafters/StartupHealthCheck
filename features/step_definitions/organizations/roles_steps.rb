Given(/^a role named "(.*?)"$/) do |role_name|
  Role.create!(name: role_name)
end

Then(/^I should see my role "(.*?)"$/) do |role_name|
  expect(page).to have_content(role_name)
end

When(/^I add my role "(.*?)"$/) do |role_name|
  fill_in "role_name", with: role_name
  click_button "Submit"
end

When(/^I edit my profile page$/) do
  visit user_path(@organization.users.first)
  click_link "edit"
end


