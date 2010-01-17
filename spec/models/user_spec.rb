require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')

describe User do
  before(:each) do
    @user = User.new
  end
  
  it "should have a time zone that defaults to UTC" do
    @user.time_zone.should == "UTC"
  end
  
  it "should allow only valid time zones" do
    @user.time_zone = 'foo'
    @user.valid?.should be_false
  end
end