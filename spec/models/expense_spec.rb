require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')

describe Expense do
  it "should have a created_on date by default" do
    Expense.new.created_on.should_not be_nil
  end
end