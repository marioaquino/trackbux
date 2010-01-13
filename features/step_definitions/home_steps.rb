Given /^I visit "([^\"]*)"$/ do |url|
  get url
end

Then /^I should see "([^\"]*)"$/ do |text|
  response_body.should contain(text)
end
