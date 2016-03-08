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
  session[:throw] = params[:throw]
  session[:computer_throw] = ["Rock", "Paper", "Scissors"].sample

  if session[:user_score].nil?
    session[:user_score] = 0
  end
  if session[:computer_score].nil?
    session[:computer_score] = 0
  end

  if session[:throw] == session[:computer_throw]
    session[:result] = "Tie!"
  else
    if session[:throw] == "Rock"
      if session[:computer_throw] == "Paper"
        session[:result] = "Computer wins!"
        session[:computer_score] += 1
      elsif session[:computer_throw] == "Scissors"
        session[:result] = "You win!"
        session[:user_score] += 1
      end
    end
    if session[:throw] == "Paper"
      if session[:computer_throw] == "Scissors"
        session[:result] = "Computer wins!"
        session[:computer_score] += 1
      elsif session[:computer_throw] == "Rock"
        session[:result] = "You win!"
        session[:user_score] += 1
      end
    end
    if session[:throw] == "Scissors"
      if session[:computer_throw] == "Rock"
        session[:result] = "Computer wins!"
        session[:computer_score] += 1
      elsif session[:computer_throw] == "Paper"
        session[:result] = "You win!"
        session[:user_score] += 1
      end
    end
  end


  if session[:computer_score] >= 2 || session[:user_score] >= 2
    session[:game_over] = true
  end

  redirect '/home'
end

post '/reset' do
  session[:computer_score] = 0
  session[:user_score] = 0
  session[:game_over] = false
  redirect '/'
end


# gameflow:
# [x] takes user input
# [x] generates computer input
# [x] compare inputs
# [x] adjust score
# [x] loop until someone wins 2
# [x] game ends when someone wins
# [x] game presents link to reset when over
