def submit_edit_form
  fill_in "user_name", with: "New Name"
  fill_in "user_email", with: "newemail@example.com"
  click_button "Save Changes"
end

When(/^I edit my profile$/) do
  find('span.glyphicon-edit').click
end

When(/^I save my changes$/) do
  submit_edit_form
end

Then(/^I should see my changes on my profile page$/) do
  find('span.glyphicon-remove-circle').click
  expect(page).to have_content("New Name")
  expect(page).to have_content("newemail@example.com")
end
