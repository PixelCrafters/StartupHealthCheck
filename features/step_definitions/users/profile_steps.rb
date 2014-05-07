def submit_edit_form
  fill_in "user_name", with: "New Name"
  fill_in "user_email", with: "newemail@example.com"
  click_button "Save Changes"
end

Then(/^I save my changes$/) do
  click_link "edit"
  submit_edit_form
end

Then(/^I should see my changes on my profile page$/) do
  page.should have_content("New Name")
  page.should have_content("newemail@example.com")
end
