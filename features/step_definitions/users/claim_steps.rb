Given(/^there is a user available$/) do
  @user1 = FactoryGirl.create(:user, name: "Example User")
end

When(/^I claim the user profile$/) do
  click_link "click here"
end

When(/^I visit the user profile page for "(.*?)"$/) do |user_name|
  user = User.where(name: user_name).first
  visit user_path(user)
end

Then(/^I should own the profile$/) do
  expect(UserAuthService.first.user).to eq(@user1)
end
