class UsersController < ApplicationController

get "/login" do
  if logged_in?
      redirect "/profile/#{@user.id}"
  else
    erb :"users/login"
  end
end

post "/login" do
  @user = User.find_by(username: params[:username])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/profile/#{@user.id}"
  else
    flash[:message] = "*The username/password (#{params[:username]}), does not exist or is incorrect*"
    redirect '/login'
  end
end

get "/signup" do
  if logged_in?
      redirect "/profile/#{@user.id}"
  else
  erb :"users/signup"
  end
end

post '/signup' do
   params.each do |k, att|
     if att.empty?
       flash[:message] = "*#{k.upcase} field required*"
       redirect '/signup'
     end
   end
     if User.find_by(username: params[:username])
       flash[:message] = "* Username not available*"
       redirect '/signup'
     else
       @user = User.create(params)
       session[:user_id] = @user.id
       @user.save
      redirect "/profile/#{@user.id}"
    end
end

get '/profile/:id' do

  if current_user != User.find(params[:id])
    redirect "/profile/#{current_user.id}"
    
  else
    @user = User.find(params[:id])
  erb :"users/profile"
  end
end

get "/logout" do
  session.clear
  redirect '/'
end


end
