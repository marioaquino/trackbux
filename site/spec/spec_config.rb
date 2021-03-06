RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.dirname(__FILE__) + "/../config/boot"
Bundler.require_env(:testing)

DataMapper.auto_migrate!

Spec::Runner.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  BudgetMinder.tap { |app| app.set :environment, :test }
end
