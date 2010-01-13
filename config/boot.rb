# This file is merely for beginning the boot process, check dependencies.rb for more information
require 'rubygems'
require 'sinatra/base'

RACK_ENV = ENV["RACK_ENV"] ||= "development" unless defined? RACK_ENV
ROOT_DIR = File.dirname(__FILE__) + '/../' unless defined? ROOT_DIR

# Helper method for file references.
# root_path("config", "settings.yml")
def root_path(*args)
  File.join(ROOT_DIR, *args)
end

# Returns the full path to the public folder along with any given additions
# public_path("images")
def public_path(*args)
  root_path('public', *args)
end

class BudgetMinder < Sinatra::Application
  # Defines basic application settings
  set :root, root_path
  set :views, root_path("app", "views")
  set :images_path, public_path("images")
  set :default_builder, 'StandardFormBuilder'
  set :environment, RACK_ENV if defined?(RACK_ENV)

  # Attempts to require all dependencies with bundler, if this fails, bundle and then try again
  def self.bundler_require_dependencies(environment=nil)
    require 'bundler'
    require File.expand_path(File.join(File.dirname(__FILE__), '/../vendor', 'gems', 'environment'))
    Bundler.require_env(environment)
  rescue LoadError => e
    puts "Bundler must be run to resolve dependencies!"
    system("cd #{ROOT_DIR}; gem bundle")
    puts "Retrying with dependencies resolved..."
    retry
  end

  # Dependencies contains all required gems and core configuration
  require File.dirname(__FILE__) + '/dependencies.rb'
end