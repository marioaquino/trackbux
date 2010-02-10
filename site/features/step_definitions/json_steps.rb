Then /^I should get "([^\"]*)" for "([^\"]*)"$/ do |value, key|
  json_response[key].should == value
end

def json_response
  ActiveSupport::JSON.decode(response_body)
end

Then /^I should get a date of "([^\"]*)" for "([^\"]*)" in "([^\"]*)" format$/ do |date_expr, field, format|
  date = eval(date_expr).to_date
  json_response[field].should == date.strftime(format)
end

Then /^I should get (\d\.?\d*) for "([^\"]*)"$/ do |percent, field|
  json_response[field].should == percent.to_f
end