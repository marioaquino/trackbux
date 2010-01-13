require File.expand_path(File.dirname(__FILE__) + '/../spec_config.rb')

describe User do
  # This spec is added because the warden_plugin registers a session deserialize
  # callback that expects the user_class to have a find method
  # This spec depends on the User fixture to setup at least 1 user
  it "should have a find method that behaves the same as the first method" do
    User.find(1).should == User.first(:id => 1)
  end
end