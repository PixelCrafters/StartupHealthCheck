Given(/^there is a user available$/) do
  @user = FactoryGirl.create(:user)
end

When(/^I visit the user profile page$/) do
  visit user_path(@user)
end

When(/^I claim the user profile$/) do
  click_link "click here"
end

Then(/^I should own the profile$/) do
  expect(UserAuthService.first.user).to eq(@user)
end
