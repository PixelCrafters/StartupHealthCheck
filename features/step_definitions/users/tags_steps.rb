Then(/^the new tag "(.*?)" should be applied to my profile$/) do |tag_name|
  expect(page).to have_content(tag_name)
end

Then(/^I should see my name when I browse by "(.*?)"$/) do |tag_name|
  visit search_path(tag: {names: ["", @user.reload.tags.first.name]})
  expect(page).to have_content(@user.name)
end

Then(/^I should not see the tag "(.*?)" on my profile$/) do |tag_name|
  expect(page).to_not have_content(tag_name)
end
