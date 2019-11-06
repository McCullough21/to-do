class TasksController < ApplicationController


 get '/new' do
   if !logged_in?
     redirect '/login'
   else
   erb :"tasks/create"
   end
 end

 post '/new' do
   @user = current_user
   if params[:title].empty?
     flash[:message] = "* Task must have a title *"
     redirect '/new'
   else
   @task = Task.create(title: params[:title], content: params[:content], :user_id => @user.id)
   @task.save
   redirect "/profile/#{@user.id}"
   end
 end

 get '/tasks/:id' do
   @task = Task.find(params[:id])
   erb :"tasks/show"
 end


end
