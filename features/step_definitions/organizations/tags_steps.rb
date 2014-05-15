Given(/^I add a new tag "(.*?)"$/) do |tag_name|
  fill_in "organization_tag_list", with: tag_name
  click_button "Add Tag"
end

Then(/^the new tag "(.*?)" should be applied to my organization$/) do |tag_name|
  page.should have_content(tag_name)
end

Then(/^I should see my organization when I browse by "(.*?)"$/) do |tag_name|
  visit tag_path(@organization.tags.first.name)
  page.should have_content(@organization.name)
end
