class BudgetMinder < Sinatra::Application
  
  get '/' do
    erb :login if session[:userid].nil?
  end
end