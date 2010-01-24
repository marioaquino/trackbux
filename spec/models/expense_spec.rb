require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')


describe Expense do
  it "should record when it was created" do
    Expense.new.created_at.should == Time.now
  end
end