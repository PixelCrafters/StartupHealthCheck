require Rails.root + 'spec/support/user_info_hashes'

def mock_auth_hash
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://localhost:3000'
  OmniAuth.config.add_mock(:auth0, USER_INFO_HASH_TWITTER)
end

Given(/^I login with "(.*?)"$/) do |auth_service|
  mock_auth_hash
  visit login_path
end

Then(/^I should be on the user profile page for "(.*?)"$/) do |name|
  page.should have_content(name)
end

Given(/^I submit an email address$/) do
  fill_in "user_email", with: "jncoops7@live.com"
  click_button "Submit"
end

Then(/^my email address should be present$/) do
  page.should have_content("jncoops7@live.com")
end
