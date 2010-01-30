require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')

describe Budget do
  before(:each) do
    @user = User.new.tap {|u| u.save }
    @account = Account.new.tap{|a| @user.add_account a }
    @budget = Budget.new(:account => @account)
  end
    
  it "should have a period that is 1 week long by default" do
    @budget.period.should == 1.week.from_now.at_midnight
  end
  
  it "should calculate the number of days until the end of the period" do
    @budget.days_until_end_of_period.should == 7
    
    @budget.period = 2.weeks.from_now + 2.days
    @budget.days_until_end_of_period.should == 16
  end

  it "should have a timezone-specific period defaulted to UTC" do
    @budget.period.zone.should == 'UTC'
  end

  it "should belong to an account" do
    @budget.account.should == @account
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
  
  it "should have an amount for the period that is initially 0.0" do
    @budget.amount.should == 0.0
  end
  context "based on a user default budget amount" do
    before(:each) do
      @user.default_budget_amount = 25.0
    end

    it "should take its initial value from the user" do
      @budget.amount.should == @user.default_budget_amount
    end
  
    it "should calculate the budget remaining based on expenses" do
      @budget.save # Required so that add_expense can save it's own transaction
      @budget.add_expense 5.41
      @budget.remaining_funds.should == 19.59
    end
  
    it "should calculate the percentage of used funds" do
      @budget.save # Required so that add_expense can save it's own transaction
      @budget.add_expense 3.35
      @budget.percent_used.should == 13.4
    end
  end
  
  it "should handle zero default budget when calculating used funds" do
    @budget.percent_used.should == 0.0
  end
end