Given(/^I add a new tag "(.*?)"$/) do |tag_name|
  fill_in "tag_list", with: tag_name
  click_button "Add Tag"
end

When(/^I remove the tag$/) do
  within(".tag-list") do
    first("a.remove-tag").click
  end
  sleep 2
end

Then(/^the new tag "(.*?)" should be applied to my organization$/) do |tag_name|
  page.should have_content(tag_name)
end

Then(/^I should see my organization when I browse by "(.*?)"$/) do |tag_name|
  tag_name = @organization.reload.tags.first.name
  visit search_path(tag: {names: [tag_name]})
  page.should have_content(@organization.name)
end

Then(/^I should not see the tag "(.*?)" on the organization profile$/) do |tag_name|
  expect(page).to_not have_content(tag_name)
end
  
