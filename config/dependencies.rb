# Dependencies contains all required gems, helpers and core configuration

class BudgetMinder < Sinatra::Application
  bundler_require_dependencies
  
  # Required middleware
  use Rack::Session::Cookie
  use Rack::Flash
  
  # Requires the initializer modules which configure specific components
  Dir[File.dirname(__FILE__) + '/initializers/*.rb'].each do |file|
    # Each initializer file contains a module called 'XxxxInitializer' (i.e HassleInitializer)
    require file
    file_class = File.basename(file, '.rb').classify
    register "#{file_class}Initializer".constantize
  end
 
  # Returns the list of load paths for this sinatra application
  def self.file_loading_paths
    ["lib/**/*.rb", "app/helpers/**/*.rb", "app/routes/**/*.rb", 
     "app/models/*.rb", "app/mailers/*.rb"]
  end

  # Require all the folders and files necessary to run the application
  file_loading_paths.each { |load_path| Dir[root_path(load_path)].each { |file| require file } }
 
  DataMapper.auto_migrate!
 
  # Exposes 'partial' method
  register SinatraMore::RenderPlugin
  
  # Exposes form builders and helpers
  register SinatraMore::MarkupPlugin
    
  # Required helpers
  helpers ViewHelpers
end
