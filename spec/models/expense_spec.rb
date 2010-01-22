require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')


describe Expense do
  it "should have a created_on date that defaults to now" do
    date = Expense.new.created_on
    date.should be > 1.second.ago and date.should be < 1.second.from_now
  end
end