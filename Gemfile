# Run 'gem bundle' anytime you add a new gem dependency
# 
clear_sources
source 'http://gemcutter.org'
# Base requirements
gem 'sinatra'
gem 'sinatra_more'
gem 'rack-flash'
gem 'warden'
gem 'bcrypt-ruby', :require_as => 'bcrypt'

# Component requirements
gem 'haml'
gem 'hassle'
gem 'dm-core'
gem 'dm-validations'

# Testing requirements
gem 'rr', :only => :testing
gem 'rspec', :only => :testing
gem 'rack-test', :require_as => 'rack/test', :only => :testing
gem 'dm-sweatshop', :only => :testing
gem 'cucumber', :only => :testing
gem 'webrat', :only => :testing
gem 'data_objects', :only => [:development, :testing]
gem 'do_sqlite3', :only => [:development, :testing] # for dev/testing only
gem 'ruby-debug', :only => [:development, :testing]