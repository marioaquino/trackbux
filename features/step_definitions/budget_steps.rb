Given /^I ask for the budget summary$/ do
  visit "/summary/#{@user.id}.json"
end