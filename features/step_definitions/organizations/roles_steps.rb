Given(/^a role named "(.*?)"$/) do |role_name|
  Role.create!(name: role_name)
end

When(/^I add my role "(.*?)"$/) do |role_name|
  select "Employee", from: "role_id"
  click_button "Add Role"
end

When(/^I edit my profile page$/) do
  visit user_path(@organization.users.first)
  click_link "edit"
end

When(/^I remove my role "(.*?)"$/) do |role_name|
  within('.roles-table') do
    first('span.glyphicon-remove').click
  end
end

Then(/^I should see my role "(.*?)"$/) do |role_name|
  expect(page).to have_content(role_name)
end

Then(/^I should not see my role "(.*?)"$/) do |role_name|
  expect(page).to have_content(role_name)
end
