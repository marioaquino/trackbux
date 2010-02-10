require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')

describe Account do
  before(:each) do
    @account = Account.new
  end
  
  it "should start out with zero users" do
    @account.users.size.should == 0
  end
  
  context "as related to users" do
    before(:each) do
      @user = User.new.tap {|u| u.save }
      @user.add_account @account
    end
    
    it "should accept any number of users" do
      @account.users.first.should == @user
      @account.users.size.should == 1
    end
  
    it "should have a latest budget" do
      budgets = [3.weeks.ago, 1.week.from_now, 1.week.ago].map {|period| 
        Budget.new(:account => @account, :period => period)}
      @account.budgets += budgets
      @account.save
      Account.first.latest_budget.should == budgets[1]
    end
    
    it "should have a currency that defaults to the user's preferred currency" do
      @account.currency.should == @user.default_currency
    end
  end
end