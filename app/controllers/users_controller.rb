class UsersController < ApplicationController

get "/login" do
  erb :"users/login"
end

post "/login" do
  if !User.find(params[:username])
    flash[:message] = "The username #{params[:username]} does not exist or is incorrect"
    redirect '/'
  else @user = User.find(params[:username])
  end

  if @user && user.authenticate(params[:password])
    session[:user_id] == @user.id
    redirect '/user/#{@user.id}'
  end
end

get "/signup" do
erb :"users/signup"
end

end
