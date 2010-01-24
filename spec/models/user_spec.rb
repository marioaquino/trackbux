require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')

describe User do
  before(:each) do
    @user = User.new
  end
  
  after(:each) do
    User.all.map(&:destroy)
  end
  
  it "should have a time zone that defaults to UTC" do
    @user.time_zone.should == "UTC"
  end
  
  it "should allow only valid time zones" do
    @user.time_zone = 'foo'
    @user.valid?.should be_false
  end
  
  it "should strip formatted time zones and just store the words" do
    {"(GMT+07:00) Bangkok" => 'Bangkok', 
     "(GMT-05:00) Eastern Time (US & Canada)" => "Eastern Time (US & Canada)" }.each_pair do |k, v|
        @user.time_zone = k
        @user.time_zone.should == v
      end
  end
  
  it "should have a default budget amount that is zero by default" do
    @user.default_budget_amount.should == 0.0
  end
  
  it "should initially have 0 accounts" do
    @user.accounts.size == 0
  end
  
  context "related to accounts " do
    before(:each) do
      @account = Account.new
      @user.accounts << @account
    end

    it "should be able to add any number of accounts" do
      @user.accounts.size.should == 1
    end
  
    it "should treat the first account as the default account" do
      @user.default_account.should == @account
    end    
  end
end