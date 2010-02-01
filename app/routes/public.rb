class BudgetMinder < Sinatra::Application
  
  get '/' do
    erb :login if session[:userid].nil?
  end
  
  get '/summary/:id.:format' do
    u = User.first(:id => params[:id])
    case params[:format]
    when "json"
      Summary.new(u.default_account.latest_budget).to_json
    end
  end
end