RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.dirname(__FILE__) + "/../../config/boot"
Bundler.require_env(:testing)
require 'ruby-debug'
require File.dirname(__FILE__) + "/../../spec/spec_fixtures"

Webrat.configure do |config|
  config.mode = :rack
end

class MyWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat::Methods.delegate_to_session :response_code, :response_body

  def app
    BudgetMinder.tap {|app| app.set :environment, :test }
  end
end

World{MyWorld.new}