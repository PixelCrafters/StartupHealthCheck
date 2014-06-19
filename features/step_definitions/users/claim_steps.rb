Given(/^there is a user available$/) do
  @user = FactoryGirl.create(:user, name: "Example User")
  User.reindex
end

When(/^I claim the user profile$/) do
  click_link "click here"
end

When(/^I visit the user profile page for "(.*?)"$/) do |user_name|
  user = User.where(name: user_name).first
  visit user_path(user)
end

Then(/^I should own the profile$/) do
  expect(UserAuthService.first.user).to eq(@user)
end
