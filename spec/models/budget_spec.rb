require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')

describe Budget do
  before do
    @user = User.new
    @budget = Budget.new
    @budget.user = @user
  end
  
  it "should have a period that is 1 week long by default" do
    @budget.period.should == 1.week.from_now.at_midnight
  end

  it "should have a timezone-specific period defaulted to UTC" do
    @budget.period.zone.should == 'UTC'
  end

  it "should belong to a user" do
    @budget.user.should == @user
  end
  
  it "should represent the period in the user's time zone" do
    @user.time_zone = 'Vilnius'
    @budget.period.utc_offset.should == ActiveSupport::TimeZone['Vilnius'].utc_offset
  end

  it "should initially have value of 0.0 expenses" do
    @budget.total_expenses.should == 0.0
  end
  
  it "should accept new expenses and update the total" do
    @budget.save # saved as first step to simulate budget being "clean"
    [1.0, 2.0, 3.0].each{|amount| @budget.add_expense(amount)}
    @budget.total_expenses.should == 6.0
  end
end