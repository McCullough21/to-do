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
    session[:user_id] == @user.id
    redirect "/profile/#{@user.id}"
  else
    flash[:message] = "The username #{params[:username]} does not exist or is incorrect"
    redirect '/'
  end
end

get "/signup" do
erb :"users/signup"
end

post '/signup' do
   params.each do |att|
     if att.empty?
       flash[:message] = "#{att} field was empty"
       redirect '/signup'
     end
   end
       user = User.create(params)
       user.save
      redirect "/profile/#{user.id}"
end

get '/profile/:id' do
  @user = User.find(params[:id])
  erb :"users/profile"
end



end
