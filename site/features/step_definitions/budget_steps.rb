Given /^I ask for the budget summary$/ do
  visit "/summary/#{@user.id}.json"
end

Given /^I add an expense of "([^\"]*)"$/ do |amount|
  post "/expense/#{@user.id}", "amount=#{amount}"
end