def mock_auth_hash
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = {
    'provider' => 'twitter',
    'uid' => '123545',
    'user_info' => {
      'name' => 'mockuser',
      'image' => 'mock_user_thumbnail_url'
    },
    'credentials' => {
      'token' => 'mock_token',
      'secret' => 'mock_secret'
    }
  }
end

Given(/^I click the login button$/) do
  visit '/'
  mock_auth_hash
  click_button "Login"
end

Given(/^I select Twitter$/) do
  find(".a0-twitter").click
end

Given(/^Twitter authorizes me$/) do
  click_button "Sign In"
end

Then(/^I should be logged in$/) do
  page.should have_content("Welcome")
end

Given(/^I have registered$/) do
  pending # express the regexp above with the code you wish you had
end
