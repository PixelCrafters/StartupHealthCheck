def submit_edit_form
  fill_in "user_name", with: "New Name"
  fill_in "user_email", with: "newemail@example.com"
  click_button "Save Changes"
end

When(/^I save my changes$/) do
  submit_edit_form
end

When(/^I edit my profile page$/) do
  if @organization.present?
    visit user_path(@organization.users.first)
  end
  find('span.glyphicon-edit').click
end

When(/^I unsubscribe from the email digest$/) do
  find("#email_digest").set(false)
end

Then(/^I should see my changes on my profile page$/) do
  expect(page).to have_content("New Name")
end

Then(/^I should be unsubscribed$/) do
  checkbox = find('#email_digest')
  expect(checkbox).to_not be_checked
end

When(/^I click change on my profile image$/) do
  click_on "Change"
end

When(/^I select a file$/) do
  page.attach_file('avatar', 'app/features/support/images/yay-programming.gif')
end

Then(/^I should see my new avatar on my profile$/) do
  expect(page).to have_image('avatar')
end
