When /^I am not authenticated$/ do
  # do nothing to mock authentication
end

Given /^I am logged in as "([^\"]*)"$/ do |user|
  visit '/admin'
  Given "I login with username \"#{user}\" and password \"#{user}\""
end

Given /^I click "([^\"]*)"$/ do |link|
  click_link link
end

When /^I press "([^\"]*)"$/ do |button|
  click_button button
end

Then /^I should see a "([^\"]*)" field$/ do |label|
  field_named(label).should_not be_nil
end

Then /^I should see a field labeled "([^\"]*)"$/ do |label|
  field_labeled(label).should_not be_nil
end

Then /^I should see a "([^\"]*)" button$/ do |name|
  field_by_xpath("//input[@value='#{name}']").should_not be_nil
end

Then /^I should be redirected to the "([^\"]*)" page$/ do |path|
  follow_redirect!
  Then "I should be on the \"#{path}\" page"
end

Then /^I should be on the "([^\"]*)" page$/ do |path|
  last_request.path.should == path
end

Given /^I login with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  fill_in 'username', :with => username
  fill_in 'password', :with => password
  click_button 'Sign in'
end

When /^I fill in "([^\"]*)" for the "([^\"]*)" field$/ do |value, labeled_field|
  fill_in labeled_field, :with => value
end
