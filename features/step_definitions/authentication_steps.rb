require Rails.root + 'spec/support/user_info_hashes'

def mock_auth_hash
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://localhost:3000'
  OmniAuth.config.add_mock(:auth0, USER_INFO_HASH_TWITTER)
end

Given(/^I login with "(.*?)"$/) do |auth_service|
  visit login_path
  expect(page).to have_css(".auth-btns")
end

Then(/^I should be on the user profile page for "(.*?)"$/) do |name|
  expect(page).to have_content(name)
end

Given(/^I submit an email address$/) do
  expect(page).to have_css(".modal")
  fill_in "user_email", with: "jncoops7@live.com"
  click_button "Submit"
end

