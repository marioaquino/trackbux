class BudgetMinder < Sinatra::Application
  
  post '/unauthenticated/?' do
    flash[:error] = "Incorrect username or password supplied"
    status 401
    erb :login
  end

  get '/login/?' do
    erb :login
  end

  post '/login/?' do
    
  end

  get '/logout/?' do
  end
end

