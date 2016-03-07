require "sinatra"

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe",
  expire_after: 86400
}

get '/' do
  redirect '/home'
end

get '/home' do
  erb :home
end

post '/throw' do
  session[:user_throw] = params[:user_throw]
  redirect '/home'
end
