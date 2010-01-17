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
  
  it "should strip formatted time zones and just store the words" do
    {"(GMT+07:00) Bangkok" => 'Bangkok', 
     "(GMT-05:00) Eastern Time (US & Canada)" => "Eastern Time (US & Canada)" }.each_pair do |k, v|
        @user.time_zone = k
        @user.time_zone.should == v
      end
  end
end