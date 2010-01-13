class BudgetMinder < Sinatra::Application
  
  before do
    if request.path_info =~ /^\/admin/ 
      redirect '/login' unless env['warden'].authenticated?
    end
  end
  
  get "/admin" do
    haml :admin
  end

  post '/unauthenticated/?' do
    flash[:notice] = "Incorrect username or password supplied"
    status 401
    haml :login
  end

  get '/login/?' do
    haml :login
  end

  post '/login/?' do
    env['warden'].authenticate!
    redirect "/admin"
  end

  get '/logout/?' do
    env['warden'].logout
    redirect '/'
  end
end

