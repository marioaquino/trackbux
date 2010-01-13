class BudgetMinder < Sinatra::Application
  
  get "/" do
    haml :index
  end
end