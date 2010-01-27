# Run 'gem bundle' anytime you add a new gem dependency
# 
clear_sources
source 'http://gemcutter.org'
# Base requirements
gem 'sinatra'
gem 'sinatra_more'
gem 'rack-flash'

# Component requirements
gem 'dm-core'
gem 'dm-validations'
gem 'dm-aggregates'

# Testing requirements
# gem 'rr', :only => :testing
gem 'rspec', :only => :testing
gem 'rack-test', :require_as => 'rack/test', :only => :testing
gem 'cucumber', :only => :testing
gem 'webrat', :only => :testing
gem 'data_objects', :only => [:development, :testing]
gem 'do_sqlite3', :only => [:development, :testing] # for dev/testing only
gem 'ruby-debug', :only => [:development, :testing]