require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash, sweep: true
  end

  get "/" do
    if logged_in?
      redirect "/profile/#{@user.id}"
    else
    erb :"users/index"
    end
  end



  #welcome page
  #signin/login
  #task show page have edit / "complete(delete)"
  #profile with add or delete(check mark) task or edit a task
  #logout
  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @user ||= User.find_by(id: session[:user_id])
    end
  end

end
