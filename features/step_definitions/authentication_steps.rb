def mock_auth_hash
  OmniAuth.config.test_mode = true
  Capybara.default_host = 'http://localhost:3000'

  OmniAuth.config.add_mock(:twitter, {
    :uid => '12345',
    :info => {
      :name => 'twitteruser',
    }
  })
end

Given(/^I login with "(.*?)"$/) do |auth_service|
  visit '/'
  mock_auth_hash
end

Then(/^I should be on the user profile page for "(.*?)"$/) do |name|
  page.should have_content("Welcome")
end
