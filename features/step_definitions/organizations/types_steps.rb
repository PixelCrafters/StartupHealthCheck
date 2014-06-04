When(/^I add a type "(.*?)"$/) do |type_name|
  select type_name, from: "type_id"
  click_button "Add Type"
end

When(/^I remove the type$/) do
  within('.types-table') do
    first('span.glyphicon-remove').click
  end
end

Then(/^I should see the type "(.*?)" on my profile$/) do |type_name|
  within('.types-table') do
    expect(page).to have_content(type_name)
  end
end

Then(/^I should not see the type "(.*?)" on my profile$/) do |type_name|
  within('.types-table') do
    expect(page).to_not have_content(type_name)
  end
end
